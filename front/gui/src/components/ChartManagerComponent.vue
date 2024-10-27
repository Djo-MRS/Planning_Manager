<template>
  <div class="chart-manager container">
    <h2 class="text-center mb-4">Chart Manager pour {{ username }}</h2>
    
    <div class="row">
      <!-- Graphique en barres pour les heures travaillées quotidiennes -->
      <div class="col-md-4 mb-3">
        <div class="card shadow-sm">
          <div class="card-header text-center">Heures quotidiennes</div>
          <div class="card-body p-2">
            <BarChart
              v-if="chartData.barChartData.labels.length && chartData.barChartData.datasets.length"
              :data="chartData.barChartData"
            />
          </div>
        </div>
      </div>

      <!-- Graphique en ligne pour la progression hebdomadaire -->
      <div class="col-md-4 mb-3">
        <div class="card shadow-sm">
          <div class="card-header text-center">Progression Hebdomadaire</div>
          <div class="card-body p-2">
            <LineChart
              v-if="chartData.lineChartData.labels.length && chartData.lineChartData.datasets.length"
              :data="chartData.lineChartData"
            />
          </div>
        </div>
      </div>

      <!-- Graphique en secteurs pour la répartition des heures par projet -->
      <div class="col-md-4 mb-3">
        <div class="card shadow-sm">
          <div class="card-header text-center">Répartition par Projet</div>
          <div class="card-body p-2">
            <PieChart
              v-if="chartData.pieChartData.labels.length && chartData.pieChartData.datasets.length"
              :data="chartData.pieChartData"
            />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { Bar, Line, Pie } from "vue-chartjs";
import { defineComponent, reactive, ref, onMounted } from "vue";
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  BarElement,
  LineElement,
  PointElement,
  CategoryScale,
  LinearScale,
  ArcElement,
} from "chart.js";

ChartJS.register(
  Title,
  Tooltip,
  Legend,
  BarElement,
  LineElement,
  PointElement,
  CategoryScale,
  LinearScale,
  ArcElement
);

export default defineComponent({
  name: "ChartManager",
  components: {
    BarChart: Bar,
    LineChart: Line,
    PieChart: Pie,
  },
  setup() {
    const username = ref("");
    const chartData = reactive({
      barChartData: { labels: [], datasets: [] },
      lineChartData: { labels: [], datasets: [] },
      pieChartData: { labels: [], datasets: [] },
    });

    const getUserData = async () => {
      const csrfToken = document.cookie.split("c-xsrf-token=")[1]?.split(";")[0];
      const token = localStorage.getItem("token");

      try {
        // Récupérer les informations de l'utilisateur
        const responseUser = await fetch(`http://localhost:4000/api/users/1`, {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
            "Authorization": `Bearer ${token}`,
            "X-CSRF-Token": csrfToken,
          },
          credentials: "include",
        });
        const resultUser = await responseUser.json();
        const user = resultUser.data;
        username.value = `${user.firstname} ${user.lastname}`;

        // Récupérer les heures travaillées
        const responseWorkingtime = await fetch(
          `http://localhost:4000/api/workingtime/${user.id}`,
          {
            method: "GET",
            headers: {
              "Content-Type": "application/json",
              "Authorization": `Bearer ${token}`,
              "X-CSRF-Token": csrfToken,
            },
            credentials: "include",
          }
        );
        const resultWorkingtime = await responseWorkingtime.json();
        const workingtimes = resultWorkingtime.data;

        // 1. Calcul des heures journalières pour le graphique en barres
        const dailyHours = workingtimes.reduce((acc, entry) => {
          const day = new Date(entry.start).toLocaleDateString("fr-FR", { weekday: "long" });
          const hours = (new Date(entry.end) - new Date(entry.start)) / 3600000;
          acc[day] = (acc[day] || 0) + hours;
          return acc;
        }, {});
        chartData.barChartData = {
          labels: Object.keys(dailyHours),
          datasets: [
            {
              label: "Heures travaillées",
              backgroundColor: "#42A5F5",
              data: Object.values(dailyHours),
            },
          ],
        };

        // 2. Progression Hebdomadaire
        const weeklyProgression = [];
        const weeklyHours = {};

        workingtimes.forEach(entry => {
          const weekNumber = getWeekNumber(new Date(entry.start));
          const hours = (new Date(entry.end) - new Date(entry.start)) / 3600000;
          weeklyHours[weekNumber] = (weeklyHours[weekNumber] || 0) + hours;
        });

        Object.keys(weeklyHours).sort().forEach(week => {
          weeklyProgression.push(weeklyHours[week]);
        });
        chartData.lineChartData = {
          labels: Object.keys(weeklyHours).map(week => `Semaine ${week}`),
          datasets: [
            {
              label: "Heures travaillées",
              borderColor: "#66BB6A",
              fill: false,
              data: weeklyProgression.length ? weeklyProgression : [0],
            },
          ],
        };

        // 3. Répartition par Projet ou Tâche pour le graphique en secteurs
        const projectDistribution = {};
        workingtimes.forEach(entry => {
          const project = entry.project || "Projet Inconnu";
          const hours = (new Date(entry.end) - new Date(entry.start)) / 3600000;
          projectDistribution[project] = (projectDistribution[project] || 0) + hours;
        });

        chartData.pieChartData = {
          labels: Object.keys(projectDistribution),
          datasets: [
            {
              label: "Répartition par projet",
              backgroundColor: ["#FF6384", "#36A2EB", "#FFCE56", "#8D4DFF"],
              data: Object.values(projectDistribution),
            },
          ],
        };
      } catch (error) {
        console.error("Erreur lors de la récupération des données : ", error);
      }
    };

    onMounted(() => {
      getUserData();
    });

    return {
      username,
      chartData,
    };
  },
});
function getWeekNumber(date) {
  const startDate = new Date(date.getFullYear(), 0, 1);
  const days = Math.floor((date - startDate) / (24 * 60 * 60 * 1000));
  return Math.ceil((date.getDay() + 1 + days) / 7);
}
</script>

<style scoped>
.chart-manager {
  text-align: center;
}

.card {
  background-color: #f9f9f9;
  border-radius: 8px;
  overflow: hidden;
}

.card-header {
  font-size: 1.1em;
  font-weight: 500;
  color: #333;
  background-color: #f1f1f1;
  padding: 0.75em;
}

.card-body {
  padding: 1em;
}

.shadow-sm {
  box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
}
</style>
