(function(){"use strict";var e={4374:function(e,t,a){var s=a(5130),n=a(6768);const o={id:"app"};function i(e,t,a,s,i,r){const l=(0,n.g2)("NavBarComponent"),c=(0,n.g2)("HomeView"),d=(0,n.g2)("router-view");return(0,n.uX)(),(0,n.CE)(n.FK,null,[(0,n.bF)(l),(0,n.bF)(c),(0,n.Lk)("div",o,[(0,n.bF)(d),r.isAuthenticated?((0,n.uX)(),(0,n.CE)("button",{key:0,onClick:t[0]||(t[0]=(...e)=>r.logout&&r.logout(...e))},"Déconnexion")):(0,n.Q3)("",!0)])],64)}a(4114);const r={class:"box-group"};function l(e,t,a,s,o,i){const l=(0,n.g2)("MDBBtn"),c=(0,n.g2)("MDBBtnGroup");return(0,n.uX)(),(0,n.CE)("div",r,[(0,n.bF)(c,{class:"button-group rounded-pill"},{default:(0,n.k6)((()=>[(0,n.bF)(l,{color:"light",onClick:t[0]||(t[0]=e=>i.goToPage("/workingtime"))},{default:(0,n.k6)((()=>t[3]||(t[3]=[(0,n.Lk)("i",{class:"fas fa-calendar-alt icon"},null,-1)]))),_:1}),(0,n.bF)(l,{color:"light",onClick:t[1]||(t[1]=e=>i.goToPage("/manager"))},{default:(0,n.k6)((()=>t[4]||(t[4]=[(0,n.Lk)("i",{class:"fas fa-users-cog icon"},null,-1)]))),_:1}),(0,n.bF)(l,{color:"light",onClick:t[2]||(t[2]=e=>i.goToPage("/request"))},{default:(0,n.k6)((()=>t[5]||(t[5]=[(0,n.Lk)("i",{class:"fas fa-envelope icon"},null,-1)]))),_:1})])),_:1})])}var c=a(5846),d={name:"NavBarComponent",components:{MDBBtnGroup:c.nv,MDBBtn:c.al},methods:{goToPage(e){this.$router.push(e)}},data(){return{collapse2:!1}}},u=a(1241);const m=(0,u.A)(d,[["render",l]]);var p=m;const b={class:"container-grid"},f={class:"main-content"},g={class:"right-bar"};function h(e,t,a,s,o,i){const r=(0,n.g2)("HomeComponent"),l=(0,n.g2)("RightBarComponent"),c=(0,n.g2)("NavBarComponent");return(0,n.uX)(),(0,n.CE)("div",b,[(0,n.Lk)("div",f,[(0,n.bF)(r)]),(0,n.Lk)("section",g,[(0,n.bF)(l)]),(0,n.bF)(c)])}const v={class:"column"},k={class:"top-column"};function w(e,t,a,s,o,i){const r=(0,n.g2)("MDBIcon"),l=(0,n.g2)("MDBBtn");return(0,n.uX)(),(0,n.CE)("div",v,[(0,n.Lk)("div",k,[(0,n.bF)(l,{color:"light",floating:"",class:"profile-button",onClick:t[0]||(t[0]=e=>i.goToPage("/profile"))},{default:(0,n.k6)((()=>[(0,n.bF)(r,{icon:"user",style:{"font-size":"25px"}})])),_:1}),(0,n.bF)(l,{color:"light",floating:"",class:"notif-button",onClick:t[1]||(t[1]=e=>i.goToPage("/notif"))},{default:(0,n.k6)((()=>[(0,n.bF)(r,{icon:"bell",style:{"font-size":"18px"}})])),_:1})]),(0,n.bF)(l,{color:"light",floating:"",class:"notif-button",onClick:t[2]||(t[2]=e=>i.goToPage("/help"))},{default:(0,n.k6)((()=>[(0,n.bF)(r,{icon:"question",style:{"font-size":"18px"}})])),_:1})])}var y={name:"RightBarComponent",components:{MDBBtn:c.al,MDBIcon:c.$u},methods:{goToPage(e){this.$router.push(e)}},data(){return{}}};const C=(0,u.A)(y,[["render",w]]);var D=C,F=a(144),L=a(1387),E={__name:"HomeComponent",setup(e){return(e,t)=>((0,n.uX)(),(0,n.CE)("main",null,[(0,n.bF)((0,F.R1)(L.Tp))]))}};const T=E;var U=T,I={name:"App",components:{HomeComponent:U,NavBarComponent:p,RightBarComponent:D}};const M=(0,u.A)(I,[["render",h]]);var B=M,S={name:"App",components:{HomeView:B,NavBarComponent:p},computed:{isAuthenticated(){return!!localStorage.getItem("userId")}},methods:{logout(){localStorage.removeItem("xsrfToken"),localStorage.removeItem("userId"),localStorage.removeItem("roleId"),this.$router.push("/sign_in")}}};const V=(0,u.A)(S,[["render",i]]);var _=V;function A(e,t,a,s,o,i){const r=(0,n.g2)("UserComponent");return(0,n.uX)(),(0,n.CE)("div",null,[(0,n.bF)(r)])}var x=a(4232);const X={class:"user"},P={class:"text-center mb-3"},O={key:0,class:"mt-3"},q=["value"],R={class:"text-center mb-3"},W={key:0,class:"mt-3"},j={class:"text-center mb-3"},N={key:0,class:"mt-3"};function $(e,t,a,o,i,r){const l=(0,n.g2)("MDBInput"),c=(0,n.g2)("MDBBtn"),d=(0,n.g2)("MDBCol"),u=(0,n.g2)("MDBRow"),m=(0,n.g2)("MDBIcon"),p=(0,n.g2)("MDBContainer");return(0,n.uX)(),(0,n.CE)("div",X,[(0,n.bF)(p,null,{default:(0,n.k6)((()=>[(0,n.bF)(u,null,{default:(0,n.k6)((()=>[(0,n.bF)(d,null,{default:(0,n.k6)((()=>[t[12]||(t[12]=(0,n.Lk)("h2",null,"Create a user",-1)),(0,n.Lk)("div",P,[(0,n.Lk)("form",{onSubmit:t[2]||(t[2]=(0,s.D$)(((...e)=>r.createUser&&r.createUser(...e)),["prevent"]))},[(0,n.bF)(l,{label:"Username",modelValue:i.createUsername,"onUpdate:modelValue":t[0]||(t[0]=e=>i.createUsername=e),required:"",class:"mb-3"},null,8,["modelValue"]),(0,n.bF)(l,{label:"Email",type:"email",modelValue:i.createEmail,"onUpdate:modelValue":t[1]||(t[1]=e=>i.createEmail=e),required:"",class:"mb-3"},null,8,["modelValue"]),(0,n.bF)(c,{type:"submit",class:"btn btn-primary btn-block mb-4"},{default:(0,n.k6)((()=>t[11]||(t[11]=[(0,n.eW)("Create user")]))),_:1})],32),i.message?((0,n.uX)(),(0,n.CE)("div",O,(0,x.v_)(i.message),1)):(0,n.Q3)("",!0)])])),_:1})])),_:1}),(0,n.bF)(u,null,{default:(0,n.k6)((()=>[(0,n.bF)(d,null,{default:(0,n.k6)((()=>[t[14]||(t[14]=(0,n.Lk)("h2",null,"Select a user",-1)),(0,n.bo)((0,n.Lk)("select",{"onUpdate:modelValue":t[3]||(t[3]=e=>i.selectedUserId=e),onChange:t[4]||(t[4]=(...e)=>r.selectUser&&r.selectUser(...e)),class:"form-select form-select-lg mb-3 mt-3 col-6"},[t[13]||(t[13]=(0,n.Lk)("option",{disabled:"",value:""},"Select a user",-1)),((0,n.uX)(!0),(0,n.CE)(n.FK,null,(0,n.pI)(i.users,(e=>((0,n.uX)(),(0,n.CE)("option",{key:e.id,value:e.id},(0,x.v_)(e.username),9,q)))),128))],544),[[s.u1,i.selectedUserId]])])),_:1})])),_:1}),(0,n.bF)(u,null,{default:(0,n.k6)((()=>[(0,n.bF)(d,null,{default:(0,n.k6)((()=>[t[16]||(t[16]=(0,n.Lk)("h2",null,"Update user",-1)),(0,n.Lk)("div",R,[(0,n.Lk)("form",{onSubmit:t[7]||(t[7]=(0,s.D$)(((...e)=>r.updateUser&&r.updateUser(...e)),["prevent"]))},[(0,n.bF)(l,{label:"Username",modelValue:i.username,"onUpdate:modelValue":t[5]||(t[5]=e=>i.username=e),required:"",class:"mb-3"},null,8,["modelValue"]),(0,n.bF)(l,{label:"Email",type:"email",modelValue:i.email,"onUpdate:modelValue":t[6]||(t[6]=e=>i.email=e),required:"",class:"mb-3"},null,8,["modelValue"]),(0,n.bF)(c,{type:"submit",class:"btn btn-primary btn-block mb-4"},{default:(0,n.k6)((()=>t[15]||(t[15]=[(0,n.eW)("Update")]))),_:1})],32),i.messageUpdated?((0,n.uX)(),(0,n.CE)("div",W,(0,x.v_)(i.messageUpdated),1)):(0,n.Q3)("",!0)])])),_:1}),(0,n.bF)(d,null,{default:(0,n.k6)((()=>[t[18]||(t[18]=(0,n.Lk)("h2",null,"Delete user",-1)),(0,n.Lk)("div",j,[(0,n.Lk)("form",{onSubmit:t[10]||(t[10]=(0,s.D$)(((...e)=>r.deleteUser&&r.deleteUser(...e)),["prevent"]))},[(0,n.bF)(l,{label:"Username",modelValue:i.username,"onUpdate:modelValue":t[8]||(t[8]=e=>i.username=e),disabled:"",class:"mb-3"},null,8,["modelValue"]),(0,n.bF)(l,{label:"Email",type:"email",modelValue:i.email,"onUpdate:modelValue":t[9]||(t[9]=e=>i.email=e),disabled:"",class:"mb-3"},null,8,["modelValue"]),(0,n.bF)(c,{type:"submit",class:"btn btn-danger btn-block mb-4"},{default:(0,n.k6)((()=>t[17]||(t[17]=[(0,n.eW)("Delete")]))),_:1})],32),i.messageDeleted?((0,n.uX)(),(0,n.CE)("div",N,(0,x.v_)(i.messageDeleted),1)):(0,n.Q3)("",!0)])])),_:1})])),_:1}),(0,n.bF)(m,{icon:"camera-retro",size:"10x"})])),_:1})])}var J={name:"UserComponent",components:{MDBContainer:c.Dj,MDBInput:c.gk,MDBBtn:c.al,MDBCol:c.m6,MDBRow:c.gU,MDBIcon:c.$u},data(){return{username:"",email:"",users:[],selectedUserId:"",message:"",messageUpdated:"",messageDeleted:"",createUsername:"",createEmail:""}},mounted(){this.getUsers()},methods:{async getUsers(){try{const e=await fetch("http://localhost:4000/api/users");this.users=(await e.json()).data}catch(e){this.message="Error getting users: "+e.message}},selectUser(){const e=this.users.find((e=>e.id===this.selectedUserId));e?(this.username=e.username,this.email=e.email):(this.username="",this.email="")},async createUser(){try{const e=await fetch("http://localhost:4000/api/users",{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({user:{username:this.createUsername,email:this.createEmail}})});e.ok?(this.message="User created successfully!",this.createUsername="",this.createEmail="",this.messageDeleted="",this.messageUpdated="",await this.getUsers()):this.message="Error creating user: "+e.statusText}catch(e){this.message="Error creating user: "+e.message}},async updateUser(){try{const e=await fetch("http://localhost:4000/api/users/"+this.selectedUserId,{method:"PUT",headers:{"Content-Type":"application/json"},body:JSON.stringify({user:{username:this.username,email:this.email}})});e.ok?(this.messageUpdated="User updated successfully!",this.messageDeleted="",this.message="",await this.getUsers()):this.messageUpdated="Error updating user: "+e.statusText}catch(e){this.messageUpdated="Error updating user: "+e.message}},async deleteUser(){try{const e=await fetch("http://localhost:4000/api/users/"+this.selectedUserId,{method:"DELETE",headers:{"Content-Type":"application/json"}});204===e.status?(this.messageDeleted="User deleted successfully!",this.messageUpdated="",this.message="",this.email="",this.username="",await this.getUsers()):this.messageDeleted="Error deleting user: "+e.statusText}catch(e){this.messageDeleted="Error deleting user: "+e.message}}}};const z=(0,u.A)(J,[["render",$],["__scopeId","data-v-57784966"]]);var H=z,K={name:"UserView",components:{UserComponent:H}};const Q=(0,u.A)(K,[["render",A]]);var G=Q;function Y(e,t,a,s,o,i){const r=(0,n.g2)("WorkingTimeComponent");return(0,n.uX)(),(0,n.CE)("div",null,[(0,n.bF)(r)])}function Z(e,t,a,s,o,i){const r=(0,n.g2)("ClockingComponent"),l=(0,n.g2)("MDBCol"),c=(0,n.g2)("CalendarComponent"),d=(0,n.g2)("MDBRow");return(0,n.uX)(),(0,n.Wv)(d,null,{default:(0,n.k6)((()=>[(0,n.bF)(l,{md:"4"},{default:(0,n.k6)((()=>[(0,n.bF)(r)])),_:1}),(0,n.bF)(l,{md:"8"},{default:(0,n.k6)((()=>[(0,n.bF)(c)])),_:1})])),_:1})}function ee(e,t,a,s,o,i){const r=(0,n.g2)("FullCalendar");return(0,n.uX)(),(0,n.Wv)(r,{options:o.calendarOptions},null,8,["options"])}var te=a(3535),ae=a(9842),se={name:"CalendarComponent",components:{FullCalendar:te.A},data(){return{workingTimes:[],calendarOptions:{plugins:[ae.A],initialView:"timeGridWeek",events:[],height:600}}},mounted(){this.getWorkingTimes()},methods:{async getWorkingTimes(){try{const e=await fetch("http://localhost:4000/api/workingtime/8"),t=await e.json();console.log("data length: ",t.data.length),this.workingTimes=[];for(let a=0;a<t.data.length;a++)console.log("item : "+t.data[a].start),this.workingTimes.push({title:"Working time",start:t.data[a].start,end:t.data[a].end});this.calendarOptions={...this.calendarOptions,events:[...this.workingTimes]},console.log("Updated workingTimes: ",this.workingTimes)}catch(e){console.error("Error fetching working times: ",e)}}}};const ne=(0,u.A)(se,[["render",ee]]);var oe=ne;const ie={key:0,class:"clocking p-6 max-w-lg mx-auto bg-white rounded-xl shadow-md space-y-4"},re={class:"mb-4"},le=["value"],ce={key:0,class:"mt-4"},de={class:"text-xl font-bold text-center text-gray-700 mb-4"},ue={class:"flex justify-center mb-4"},me={class:"flex justify-between px-4"},pe={class:"text-md font-medium text-gray-700"},be={class:"text-md font-medium text-gray-700"};function fe(e,t,a,o,i,r){return i.users.length?((0,n.uX)(),(0,n.CE)("div",ie,[(0,n.Lk)("div",re,[t[5]||(t[5]=(0,n.Lk)("label",{for:"userSelect",class:"block text-sm font-medium text-gray-700 mb-2"},"Sélectionner un utilisateur :",-1)),(0,n.bo)((0,n.Lk)("select",{id:"userSelect","onUpdate:modelValue":t[0]||(t[0]=e=>i.selectedUserId=e),onChange:t[1]||(t[1]=(...e)=>r.selectUser&&r.selectUser(...e)),class:"block w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-blue-500 focus:border-blue-500"},[t[4]||(t[4]=(0,n.Lk)("option",{value:"",disabled:"",selected:""},"Choisissez un utilisateur...",-1)),((0,n.uX)(!0),(0,n.CE)(n.FK,null,(0,n.pI)(i.users,(e=>((0,n.uX)(),(0,n.CE)("option",{key:e.id,value:e.id},(0,x.v_)(e.username),9,le)))),128))],544),[[s.u1,i.selectedUserId]])]),i.selectedUserId?((0,n.uX)(),(0,n.CE)("div",ce,[(0,n.Lk)("h3",de,(0,x.v_)(i.currentDateTime),1),(0,n.Lk)("div",ue,[i.clockIn?((0,n.uX)(),(0,n.CE)("button",{key:1,onClick:t[3]||(t[3]=(...e)=>r.clockOut&&r.clockOut(...e)),class:"btn btn-primary"}," Badger en sortie ")):((0,n.uX)(),(0,n.CE)("button",{key:0,onClick:t[2]||(t[2]=(...e)=>r.clockInUser&&r.clockInUser(...e)),class:"btn btn-primary"}," Badger en entrée "))]),(0,n.Lk)("div",me,[(0,n.Lk)("p",pe,[t[6]||(t[6]=(0,n.eW)(" Commencé à : ")),(0,n.Lk)("span",null,(0,x.v_)(i.formattedStartTime||"--"),1)]),(0,n.Lk)("p",be,[t[7]||(t[7]=(0,n.eW)(" Fini à : ")),(0,n.Lk)("span",null,(0,x.v_)(i.formattedEndTime||"--"),1)])])])):(0,n.Q3)("",!0)])):(0,n.Q3)("",!0)}var ge={name:"ClockingComponent",data(){return{users:[],selectedUserId:"",clockIn:!1,startDateTime:null,formattedStartDateTime:"",formattedStartTime:"",formattedEndTime:"",errorMessage:"",lastAction:null,currentDateTime:(new Date).toLocaleString("fr-FR",{weekday:"long",year:"numeric",month:"long",day:"numeric",hour:"2-digit",minute:"2-digit",second:"2-digit"})}},mounted(){this.getUsers(),this.updateCurrentDateTime(),this.selectedUserId&&this.fetchClockStatus()},methods:{async getUsers(){try{const e=await fetch("http://localhost:4000/api/users");if(!e.ok)throw new Error("Erreur lors de la récupération des utilisateurs");const t=await e.json();this.users=t.data}catch(e){this.errorMessage="Erreur lors de la récupération des utilisateurs : "+e.message}},async selectUser(){this.selectedUserId?await this.fetchClockStatus():(this.clockIn=!1,this.lastAction=null,this.startDateTime=null,this.formattedStartDateTime="",this.formattedEndTime="",this.errorMessage="")},async fetchClockStatus(){this.errorMessage="";try{const e=await fetch(`http://localhost:4000/api/clocks/${this.selectedUserId}`);if(!e.ok){if(404===e.status)return this.clockIn=!1,this.lastAction=null,this.startDateTime=null,this.formattedStartDateTime="",void(this.formattedEndTime="");throw new Error("Erreur lors de la récupération de l'état de pointage")}const t=await e.json(),a=t.data;if(Array.isArray(a)&&a.length>0){const e=a.sort(((e,t)=>new Date(t.time)-new Date(e.time)))[0];e?(this.clockIn=e.status,this.startDateTime=e.time,this.formattedStartDateTime=new Date(this.startDateTime).toLocaleString("fr-FR"),this.formattedStartTime=new Date(this.startDateTime).toLocaleTimeString("fr-FR",{hour:"2-digit",minute:"2-digit",second:"2-digit"}),this.formattedEndTime=e.status?"":new Date(e.time).toLocaleTimeString("fr-FR",{hour:"2-digit",minute:"2-digit",second:"2-digit"}),this.lastAction=e.status?"clockIn":"clockOut"):(this.clockIn=!1,this.lastAction=null)}else this.clockIn=!1,this.lastAction=null,this.startDateTime=null,this.formattedStartDateTime="",this.formattedEndTime=""}catch(e){console.error("Erreur lors de la récupération de l'état de pointage",e),this.errorMessage=`Erreur : ${e.message}`}},async clockInUser(){try{const e=await fetch(`http://localhost:4000/api/clocks/${this.selectedUserId}`,{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({clock:{clockIn:!0,time:(new Date).toISOString()}})});if(!e.ok)throw new Error("Erreur lors du pointage");await e.json(),this.clockIn=!0,this.startDateTime=(new Date).toISOString(),this.formattedStartDateTime=(new Date).toLocaleString("fr-FR"),this.formattedStartTime=(new Date).toLocaleTimeString("fr-FR",{hour:"2-digit",minute:"2-digit",second:"2-digit"}),this.lastAction="clockIn",this.errorMessage=""}catch(e){this.errorMessage=`Erreur : ${e.message}`}},async clockOut(){try{const e=await fetch(`http://localhost:4000/api/clocks/${this.selectedUserId}`,{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({clock:{clockIn:!1,time:(new Date).toISOString()}})});if(!e.ok)throw new Error("Erreur lors du dépointage");await e.json(),this.clockIn=!1,this.lastAction="clockOut",this.startDateTime=(new Date).toISOString(),this.formattedEndTime=(new Date).toLocaleTimeString("fr-FR",{hour:"2-digit",minute:"2-digit",second:"2-digit"}),this.errorMessage="",await this.sendWorkingTime()}catch(e){this.errorMessage=`Erreur : ${e.message}`}},async sendWorkingTime(){try{const e=new Date(this.startDateTime).toISOString(),t=(new Date).toISOString(),a=await fetch(`http://localhost:4000/api/workingtime/${this.selectedUserId}`,{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({workingtime:{start:e,end:t}})});if(!a.ok)throw new Error("Erreur lors de l'envoi des données de temps de travail");this.errorMessage=""}catch(e){this.errorMessage=`Erreur lors de l'envoi des données de temps de travail : ${e.message}`}},updateCurrentDateTime(){setInterval((()=>{this.currentDateTime=(new Date).toLocaleString("fr-FR",{weekday:"long",year:"numeric",month:"long",day:"numeric",hour:"2-digit",minute:"2-digit",second:"2-digit"})}),1e3)},refresh(){this.selectedUserId&&this.fetchClockStatus()}}};const he=(0,u.A)(ge,[["render",fe],["__scopeId","data-v-06982f92"]]);var ve=he,ke={name:"WorkingTimeComponent",components:{CalendarComponent:oe,ClockingComponent:ve,MDBRow:c.gU,MDBCol:c.m6}};const we=(0,u.A)(ke,[["render",Z]]);var ye=we,Ce={name:"WorkingTimeView",components:{WorkingTimeComponent:ye}};const De=(0,u.A)(Ce,[["render",Y]]);var Fe=De;function Le(e,t,a,s,o,i){const r=(0,n.g2)("ProfileComponent");return(0,n.uX)(),(0,n.CE)("div",null,[(0,n.bF)(r)])}const Ee={class:"profile-view"};function Te(e,t){return(0,n.uX)(),(0,n.CE)("main",Ee,t[0]||(t[0]=[(0,n.Fv)('<div class="profile-container" data-v-26267c26><div class="profile-content" data-v-26267c26><section class="profile-info" data-v-26267c26><div class="profile-details" data-v-26267c26><h1 class="profile-title" data-v-26267c26>Profil</h1><div class="profile-row" data-v-26267c26><div class="profile-item" data-v-26267c26><img loading="lazy" src="https://cdn.builder.io/api/v1/image/assets/TEMP/1c18f04fefcdc9abdde53c4a5f1ff174e3d175ee995e3d195cd1dec4099be056?placeholderIfAbsent=true&amp;apiKey=1dd5640dff5747c98816899eb6d392e1" class="profile-icon" alt="Name icon" data-v-26267c26><span class="profile-label" data-v-26267c26>Name</span></div><input type="text" class="form-input" aria-label="Name input" data-v-26267c26></div><div class="profile-row" data-v-26267c26><div class="profile-item" data-v-26267c26><img loading="lazy" src="https://cdn.builder.io/api/v1/image/assets/TEMP/cc7ee409e90ba28d158a4c93a4327b6b2207a5e96fc2101271539f8895a65072?placeholderIfAbsent=true&amp;apiKey=1dd5640dff5747c98816899eb6d392e1" class="profile-icon" alt="Surname icon" data-v-26267c26><span class="profile-label" data-v-26267c26>Surname</span></div><input type="text" class="form-input" aria-label="Surname input" data-v-26267c26></div><div class="profile-row" data-v-26267c26><div class="profile-item" data-v-26267c26><img loading="lazy" src="https://cdn.builder.io/api/v1/image/assets/TEMP/509e27464df901bf921875bbb026e12ecb4955a30bf6190581e8848bf143b858?placeholderIfAbsent=true&amp;apiKey=1dd5640dff5747c98816899eb6d392e1" class="profile-icon" alt="Mail icon" data-v-26267c26><span class="profile-label" data-v-26267c26>Mail</span></div><input type="email" class="form-input" aria-label="Email input" data-v-26267c26></div><div class="profile-row" data-v-26267c26><div class="profile-item" data-v-26267c26><img loading="lazy" src="https://cdn.builder.io/api/v1/image/assets/TEMP/b9ac0243f6cbbbe5c36582f590b974b514c4abf62a5a52c4d5b130ce2c28c228?placeholderIfAbsent=true&amp;apiKey=1dd5640dff5747c98816899eb6d392e1" class="profile-icon" alt="Phone icon" data-v-26267c26><span class="profile-label" data-v-26267c26>Phone</span></div><input type="tel" class="form-input" aria-label="Phone input" data-v-26267c26></div><div class="profile-row" data-v-26267c26><div class="profile-item" data-v-26267c26><img loading="lazy" src="https://cdn.builder.io/api/v1/image/assets/TEMP/4bd16cbc188756c619de2382066dab461ca564bcfc1128a74560cc8c9ffc8db0?placeholderIfAbsent=true&amp;apiKey=1dd5640dff5747c98816899eb6d392e1" class="profile-icon" alt="Service icon" data-v-26267c26><span class="profile-label" data-v-26267c26>Service</span></div><input type="text" class="form-input" aria-label="Service input" data-v-26267c26></div><div class="profile-row" data-v-26267c26><div class="profile-item" data-v-26267c26><img loading="lazy" src="https://cdn.builder.io/api/v1/image/assets/TEMP/6aba804eaa1d8545a85a24c33aef6da56670f1863f755108481ef2d0a86bd07a?placeholderIfAbsent=true&amp;apiKey=1dd5640dff5747c98816899eb6d392e1" class="profile-icon" alt="Manager icon" data-v-26267c26><span class="profile-label" data-v-26267c26>Manager</span></div><input type="text" class="form-input" aria-label="Manager input" data-v-26267c26></div></div></section></div></div>',1)]))}const Ue={},Ie=(0,u.A)(Ue,[["render",Te],["__scopeId","data-v-26267c26"]]);var Me=Ie,Be={name:"ProfileView",components:{ProfileComponent:Me}};const Se=(0,u.A)(Be,[["render",Le]]);var Ve=Se;function _e(e,t,a,s,o,i){const r=(0,n.g2)("HelpComponent");return(0,n.uX)(),(0,n.CE)("div",null,[(0,n.bF)(r)])}const Ae={class:"help-view"};function xe(e,t){return(0,n.uX)(),(0,n.CE)("section",Ae,t[0]||(t[0]=[(0,n.Fv)('<div class="help-container" data-v-3b0b72b9><h1 class="help-title" data-v-3b0b72b9>FAQ</h1><form class="help-form" data-v-3b0b72b9><div class="question-answer-group" data-v-3b0b72b9><div class="input-group" data-v-3b0b72b9><label for="question1" class="input-label" data-v-3b0b72b9>Q1: How to use?</label></div><div class="input-group" data-v-3b0b72b9><label for="answer1" class="input-label" data-v-3b0b72b9>A1: Click submit.</label></div></div><div class="question-answer-group" data-v-3b0b72b9><div class="input-group" data-v-3b0b72b9><label for="question2" class="input-label" data-v-3b0b72b9>Q2: ...</label></div><div class="input-group" data-v-3b0b72b9><label for="answer2" class="input-label" data-v-3b0b72b9>A2: ...</label></div></div><div class="input-group" data-v-3b0b72b9><label for="userQuestion" class="input-label" data-v-3b0b72b9>Your question:</label><input id="userQuestion" type="text" class="input-field" placeholder="Type here..." data-v-3b0b72b9></div><div class="input-group" data-v-3b0b72b9><label for="userEmail" class="input-label" data-v-3b0b72b9>Your email:</label><input id="userEmail" type="email" class="input-field" placeholder="example@email.com" data-v-3b0b72b9></div><button type="submit" class="submit-button" data-v-3b0b72b9> Submit <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/240f63fefbf307ccbc5e2b7d3d61746bad14850499abc5aa060cd2f1b2e1fce5?placeholderIfAbsent=true&amp;apiKey=1dd5640dff5747c98816899eb6d392e1" alt="" class="submit-icon" data-v-3b0b72b9></button></form></div>',1)]))}const Xe={},Pe=(0,u.A)(Xe,[["render",xe],["__scopeId","data-v-3b0b72b9"]]);var Oe=Pe,qe={name:"HelpView",components:{HelpComponent:Oe}};const Re=(0,u.A)(qe,[["render",_e]]);var We=Re;function je(e,t,a,s,o,i){const r=(0,n.g2)("ManagerComponent");return(0,n.uX)(),(0,n.CE)("div",null,[(0,n.bF)(r)])}function Ne(e,t,a,s,o,i){return(0,n.uX)(),(0,n.CE)("div",null," Manager ")}var $e={name:"ManagerComponent",components:{}};const Je=(0,u.A)($e,[["render",Ne]]);var ze=Je,He={name:"WorkingTimeView",components:{ManagerComponent:ze}};const Ke=(0,u.A)(He,[["render",je]]);var Qe=Ke;const Ge={class:"body-row"};function Ye(e,t,a,s,o,i){const r=(0,n.g2)("NotifListComponent");return(0,n.uX)(),(0,n.CE)(n.FK,null,[t[0]||(t[0]=(0,n.Lk)("h2",null," Notifications ",-1)),(0,n.Lk)("div",Ge,[(0,n.bF)(r)])],64)}const Ze={class:"box-list"},et={class:"list-container"};function tt(e,t,a,s,o,i){const r=(0,n.g2)("NotifListItem");return(0,n.uX)(),(0,n.CE)("div",Ze,[t[1]||(t[1]=(0,n.Lk)("div",null,"Vos notifications",-1)),(0,n.Lk)("div",et,[(0,n.bF)(r),(0,n.bF)(r),(0,n.bF)(r),(0,n.bF)(r),(0,n.bF)(r),(0,n.bF)(r),(0,n.bF)(r),t[0]||(t[0]=(0,n.Lk)("div",{style:{"border-top":"solid 1px #8d8d8d"}},null,-1))])])}const at={class:"list-item-row"},st={class:"list-item-circle"};function nt(e,t,a,s,o,i){const r=(0,n.g2)("MDBIcon"),l=(0,n.g2)("MDBBtn");return(0,n.uX)(),(0,n.CE)("div",at,[(0,n.Lk)("div",st,[(0,n.bF)(l,{color:"light",floating:"",class:"profile-button"},{default:(0,n.k6)((()=>[(0,n.bF)(r,{icon:"user",style:{"font-size":"25px"}})])),_:1})]),t[0]||(t[0]=(0,n.Lk)("div",{class:"list-item-column"},[(0,n.Lk)("div",{class:"title-request"},"Congés acceptés"),(0,n.Lk)("div",{class:"title-message"}," Vos congés du 30 octobre ont bien été acceptées"),(0,n.Lk)("div",{class:"title-details"},"Il y a 2 mois")],-1))])}var ot={name:"RequestListItem",components:{MDBBtn:c.al,MDBIcon:c.$u}};const it=(0,u.A)(ot,[["render",nt]]);var rt=it,lt={name:"NotifListComponent",components:{NotifListItem:rt}};const ct=(0,u.A)(lt,[["render",tt]]);var dt=ct,ut={name:"NotificationView",components:{NotifListComponent:dt}};const mt=(0,u.A)(ut,[["render",Ye]]);var pt=mt;const bt={class:"body-row"};function ft(e,t,a,s,o,i){const r=(0,n.g2)("RequestFormComponent"),l=(0,n.g2)("RequestListComponent");return(0,n.uX)(),(0,n.CE)(n.FK,null,[t[0]||(t[0]=(0,n.Lk)("h2",null," Mes demandes ",-1)),(0,n.Lk)("div",bt,[(0,n.bF)(r),(0,n.bF)(l)])],64)}const gt={class:"box-form"},ht={class:"form-container"},vt={class:"date-picker-container"},kt={class:"date-picker-container"},wt={class:"comment-section"},yt={class:"submit-section"};function Ct(e,t,a,o,i,r){const l=(0,n.g2)("MDBDropdownToggle"),c=(0,n.g2)("MDBDropdownItem"),d=(0,n.g2)("MDBDropdownMenu"),u=(0,n.g2)("MDBDropdown"),m=(0,n.g2)("MDBTextarea"),p=(0,n.g2)("MDBBtn");return(0,n.uX)(),(0,n.CE)("div",gt,[t[21]||(t[21]=(0,n.Lk)("div",{class:"title-form"},"Faire une demande",-1)),(0,n.Lk)("div",ht,[(0,n.bF)(u,{modelValue:i.dropdown1,"onUpdate:modelValue":t[1]||(t[1]=e=>i.dropdown1=e),class:"dropdown-container"},{default:(0,n.k6)((()=>[t[11]||(t[11]=(0,n.Lk)("div",{class:"label"},"Type de demande",-1)),(0,n.bF)(l,{onClick:t[0]||(t[0]=e=>i.dropdown1=!i.dropdown1),color:"light",class:"dropdown-button"},{default:(0,n.k6)((()=>t[7]||(t[7]=[(0,n.eW)(" Congés payées ")]))),_:1}),(0,n.bF)(d,{"aria-labelledby":"dropdownMenuButton"},{default:(0,n.k6)((()=>[(0,n.bF)(c,{href:"#"},{default:(0,n.k6)((()=>t[8]||(t[8]=[(0,n.eW)("Congés payées")]))),_:1}),(0,n.bF)(c,{href:"#"},{default:(0,n.k6)((()=>t[9]||(t[9]=[(0,n.eW)("RTT")]))),_:1}),(0,n.bF)(c,{href:"#"},{default:(0,n.k6)((()=>t[10]||(t[10]=[(0,n.eW)("Arrêt maladie")]))),_:1})])),_:1})])),_:1},8,["modelValue"]),(0,n.bF)(u,{modelValue:i.dropdown2,"onUpdate:modelValue":t[3]||(t[3]=e=>i.dropdown2=e)},{default:(0,n.k6)((()=>[t[16]||(t[16]=(0,n.Lk)("div",{class:"label"},"Motif",-1)),(0,n.bF)(l,{onClick:t[2]||(t[2]=e=>i.dropdown2=!i.dropdown2),color:"light",class:"dropdown-button"},{default:(0,n.k6)((()=>t[12]||(t[12]=[(0,n.eW)(" Vancances ")]))),_:1}),(0,n.bF)(d,{"aria-labelledby":"dropdownMenuButton"},{default:(0,n.k6)((()=>[(0,n.bF)(c,{href:"#"},{default:(0,n.k6)((()=>t[13]||(t[13]=[(0,n.eW)("Congés payées")]))),_:1}),(0,n.bF)(c,{href:"#"},{default:(0,n.k6)((()=>t[14]||(t[14]=[(0,n.eW)("RTT")]))),_:1}),(0,n.bF)(c,{href:"#"},{default:(0,n.k6)((()=>t[15]||(t[15]=[(0,n.eW)("Arrêt maladie")]))),_:1})])),_:1})])),_:1},8,["modelValue"]),(0,n.Lk)("div",vt,[t[17]||(t[17]=(0,n.Lk)("label",{class:"date-picker-label",for:"date-input1"},"Du :",-1)),(0,n.bo)((0,n.Lk)("input",{class:"date-picker-input",type:"date",id:"date-input1","onUpdate:modelValue":t[4]||(t[4]=e=>i.selectedStartDate=e)},null,512),[[s.Jo,i.selectedStartDate]])]),(0,n.Lk)("div",kt,[t[18]||(t[18]=(0,n.Lk)("label",{class:"date-picker-label",for:"date-input2"},"Au :",-1)),(0,n.bo)((0,n.Lk)("input",{class:"date-picker-input",type:"date",id:"date-input2","onUpdate:modelValue":t[5]||(t[5]=e=>i.selectedEndDate=e)},null,512),[[s.Jo,i.selectedEndDate]])]),(0,n.Lk)("div",wt,[t[19]||(t[19]=(0,n.Lk)("div",{class:"label"},"Commentaire",-1)),(0,n.bF)(m,{rows:"4",modelValue:i.textareaValue,"onUpdate:modelValue":t[6]||(t[6]=e=>i.textareaValue=e)},null,8,["modelValue"])]),(0,n.Lk)("div",yt,[(0,n.bF)(p,{outline:"primary"},{default:(0,n.k6)((()=>t[20]||(t[20]=[(0,n.eW)("Envoyer")]))),_:1})])])])}var Dt={name:"RequestFormComponent",components:{MDBDropdown:c.Zr,MDBDropdownItem:c.Oo,MDBDropdownMenu:c.IF,MDBDropdownToggle:c.Ho,MDBTextarea:c.QP,MDBBtn:c.al},data(){return{dropdown1:!1,dropdown2:!1,selectedStartDate:null,selectedEndDate:null,textareaValue:""}}};const Ft=(0,u.A)(Dt,[["render",Ct]]);var Lt=Ft;const Et={class:"box-list"},Tt={class:"list-container"};function Ut(e,t,a,s,o,i){const r=(0,n.g2)("RequestListItem");return(0,n.uX)(),(0,n.CE)("div",Et,[t[1]||(t[1]=(0,n.Lk)("div",null,"Vos messages",-1)),(0,n.Lk)("div",Tt,[(0,n.bF)(r),(0,n.bF)(r),(0,n.bF)(r),(0,n.bF)(r),(0,n.bF)(r),(0,n.bF)(r),(0,n.bF)(r),(0,n.bF)(r),t[0]||(t[0]=(0,n.Lk)("div",{style:{"border-top":"solid 1px #8d8d8d"}},null,-1))])])}const It={class:"list-item-row"},Mt={class:"list-item-circle"};function Bt(e,t,a,s,o,i){const r=(0,n.g2)("MDBIcon"),l=(0,n.g2)("MDBBtn");return(0,n.uX)(),(0,n.CE)("div",It,[(0,n.Lk)("div",Mt,[(0,n.bF)(l,{color:"light",floating:"",class:"profile-button"},{default:(0,n.k6)((()=>[(0,n.bF)(r,{icon:"user",style:{"font-size":"25px"}})])),_:1})]),t[0]||(t[0]=(0,n.Lk)("div",{class:"list-item-column"},[(0,n.Lk)("div",{class:"title-request"},"Congés acceptés"),(0,n.Lk)("div",{class:"title-message"}," Vos congés du 30 octobre ont bien été acceptées"),(0,n.Lk)("div",{class:"title-details"},"Il y a 2 mois")],-1))])}var St={name:"RequestListItem",components:{MDBBtn:c.al,MDBIcon:c.$u}};const Vt=(0,u.A)(St,[["render",Bt]]);var _t=Vt,At={name:"RequestListComponent",components:{RequestListItem:_t}};const xt=(0,u.A)(At,[["render",Ut]]);var Xt=xt,Pt={name:"RequestView",components:{RequestFormComponent:Lt,RequestListComponent:Xt}};const Ot=(0,u.A)(Pt,[["render",ft]]);var qt=Ot;function Rt(e,t,a,s,o,i){const r=(0,n.g2)("LoginComponent");return(0,n.uX)(),(0,n.CE)("div",null,[(0,n.bF)(r)])}var Wt=a.p+"img/logohometimemanager.2f1b83e2.jpg";const jt={class:"login-container"},Nt={class:"login-form"};function $t(e,t,a,o,i,r){return(0,n.uX)(),(0,n.CE)("div",jt,[t[3]||(t[3]=(0,n.Lk)("img",{src:Wt,alt:"Logo",class:"logo"},null,-1)),(0,n.Lk)("form",Nt,[(0,n.bo)((0,n.Lk)("input",{type:"email","onUpdate:modelValue":t[0]||(t[0]=e=>i.email=e),placeholder:"Email",required:"",class:"input-field"},null,512),[[s.Jo,i.email]]),(0,n.bo)((0,n.Lk)("input",{type:"password","onUpdate:modelValue":t[1]||(t[1]=e=>i.password=e),placeholder:"Password",required:"",class:"input-field"},null,512),[[s.Jo,i.password]]),t[2]||(t[2]=(0,n.Lk)("button",{type:"submit",class:"sign-in-button"},"Se Connecter",-1))])])}var Jt={data(){return{email:"",password:""}}};const zt=(0,u.A)(Jt,[["render",$t],["__scopeId","data-v-cdf0c222"]]);var Ht=zt,Kt={name:"LoginView",components:{LoginComponent:Ht}};const Qt=(0,u.A)(Kt,[["render",Rt]]);var Gt=Qt;function Yt(e,t,a,s,o,i){const r=(0,n.g2)("SignupComponent");return(0,n.uX)(),(0,n.CE)("div",null,[(0,n.bF)(r)])}const Zt={class:"signup-container"},ea={class:"signup-form"};function ta(e,t,a,o,i,r){return(0,n.uX)(),(0,n.CE)("div",Zt,[t[6]||(t[6]=(0,n.Lk)("img",{src:Wt,alt:"Logo",class:"logo"},null,-1)),(0,n.Lk)("form",ea,[(0,n.bo)((0,n.Lk)("input",{type:"text","onUpdate:modelValue":t[0]||(t[0]=e=>i.name=e),placeholder:"Name",required:"",class:"input-field"},null,512),[[s.Jo,i.name]]),(0,n.bo)((0,n.Lk)("input",{type:"text","onUpdate:modelValue":t[1]||(t[1]=e=>i.firstname=e),placeholder:"Firstname",required:"",class:"input-field"},null,512),[[s.Jo,i.firstname]]),(0,n.bo)((0,n.Lk)("input",{type:"email","onUpdate:modelValue":t[2]||(t[2]=e=>i.email=e),placeholder:"Email",required:"",class:"input-field"},null,512),[[s.Jo,i.email]]),(0,n.bo)((0,n.Lk)("input",{type:"password","onUpdate:modelValue":t[3]||(t[3]=e=>i.password=e),placeholder:"Password",required:"",class:"input-field"},null,512),[[s.Jo,i.password]]),(0,n.bo)((0,n.Lk)("input",{type:"password","onUpdate:modelValue":t[4]||(t[4]=e=>i.confirmPassword=e),placeholder:"Confirm Password",required:"",class:"input-field"},null,512),[[s.Jo,i.confirmPassword]]),t[5]||(t[5]=(0,n.Lk)("button",{type:"submit",class:"sign-up-button"},"Inscription",-1))])])}var aa={data(){return{name:"",firstname:"",email:"",phone:"",password:"",confirmPassword:""}}};const sa=(0,u.A)(aa,[["render",ta],["__scopeId","data-v-185e6004"]]);var na=sa,oa={name:"SignupView",components:{SignupComponent:na}};const ia=(0,u.A)(oa,[["render",Yt]]);var ra=ia;const la=[{path:"/",name:"HomeView",component:B},{path:"/user",name:"UserView",component:G},{path:"/profile",name:"ProfileView",component:Ve},{path:"/help",name:"HelpView",component:We},{path:"/workingtime",name:"WorkingTimeView",component:Fe},{path:"/manager",name:"ManagerView",component:Qe},{path:"/notif",name:"NotifView",component:pt},{path:"/request",name:"RequestView",component:qt},{path:"/sign_in",component:Gt},{path:"/sign_up",component:ra}],ca=(0,L.aE)({history:(0,L.LA)(),routes:la});var da=ca;(0,s.Ef)(_).use(da).mount("#app")}},t={};function a(s){var n=t[s];if(void 0!==n)return n.exports;var o=t[s]={exports:{}};return e[s].call(o.exports,o,o.exports,a),o.exports}a.m=e,function(){var e=[];a.O=function(t,s,n,o){if(!s){var i=1/0;for(d=0;d<e.length;d++){s=e[d][0],n=e[d][1],o=e[d][2];for(var r=!0,l=0;l<s.length;l++)(!1&o||i>=o)&&Object.keys(a.O).every((function(e){return a.O[e](s[l])}))?s.splice(l--,1):(r=!1,o<i&&(i=o));if(r){e.splice(d--,1);var c=n();void 0!==c&&(t=c)}}return t}o=o||0;for(var d=e.length;d>0&&e[d-1][2]>o;d--)e[d]=e[d-1];e[d]=[s,n,o]}}(),function(){a.n=function(e){var t=e&&e.__esModule?function(){return e["default"]}:function(){return e};return a.d(t,{a:t}),t}}(),function(){a.d=function(e,t){for(var s in t)a.o(t,s)&&!a.o(e,s)&&Object.defineProperty(e,s,{enumerable:!0,get:t[s]})}}(),function(){a.g=function(){if("object"===typeof globalThis)return globalThis;try{return this||new Function("return this")()}catch(e){if("object"===typeof window)return window}}()}(),function(){a.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)}}(),function(){a.p="/"}(),function(){var e={524:0};a.O.j=function(t){return 0===e[t]};var t=function(t,s){var n,o,i=s[0],r=s[1],l=s[2],c=0;if(i.some((function(t){return 0!==e[t]}))){for(n in r)a.o(r,n)&&(a.m[n]=r[n]);if(l)var d=l(a)}for(t&&t(s);c<i.length;c++)o=i[c],a.o(e,o)&&e[o]&&e[o][0](),e[o]=0;return a.O(d)},s=self["webpackChunkgui"]=self["webpackChunkgui"]||[];s.forEach(t.bind(null,0)),s.push=t.bind(null,s.push.bind(s))}();var s=a.O(void 0,[504],(function(){return a(4374)}));s=a.O(s)})();
//# sourceMappingURL=app.057ed6e8.js.map