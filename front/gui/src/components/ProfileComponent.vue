<template>
    <main class="profile-view">
      <div class="profile-container">
        <div class="profile-content">
          <section class="profile-info">
            <div class="profile-details">
              <h1 class="profile-title">Profil</h1>
              <div class="profile-row">
                <div class="profile-item">
                  <img loading="lazy" src="https://cdn.builder.io/api/v1/image/assets/TEMP/1c18f04fefcdc9abdde53c4a5f1ff174e3d175ee995e3d195cd1dec4099be056?placeholderIfAbsent=true&apiKey=1dd5640dff5747c98816899eb6d392e1" class="profile-icon" alt="Name icon" />
                  <span class="profile-label">Name</span>
                </div>
                <input type="text" class="form-input" aria-label="Name input" />
              </div>
              <div class="profile-row">
                <div class="profile-item">
                  <img loading="lazy" src="https://cdn.builder.io/api/v1/image/assets/TEMP/cc7ee409e90ba28d158a4c93a4327b6b2207a5e96fc2101271539f8895a65072?placeholderIfAbsent=true&apiKey=1dd5640dff5747c98816899eb6d392e1" class="profile-icon" alt="Surname icon" />
                  <span class="profile-label">Surname</span>
                </div>
                <input type="text" class="form-input" aria-label="Surname input" />
              </div>
              <div class="profile-row">
                <div class="profile-item">
                  <img loading="lazy" src="https://cdn.builder.io/api/v1/image/assets/TEMP/509e27464df901bf921875bbb026e12ecb4955a30bf6190581e8848bf143b858?placeholderIfAbsent=true&apiKey=1dd5640dff5747c98816899eb6d392e1" class="profile-icon" alt="Mail icon" />
                  <span class="profile-label">Mail</span>
                </div>
                <input type="email" class="form-input" aria-label="Email input" />
              </div>
              <div class="profile-row">
                <div class="profile-item">
                  <img loading="lazy" src="https://cdn.builder.io/api/v1/image/assets/TEMP/b9ac0243f6cbbbe5c36582f590b974b514c4abf62a5a52c4d5b130ce2c28c228?placeholderIfAbsent=true&apiKey=1dd5640dff5747c98816899eb6d392e1" class="profile-icon" alt="Phone icon" />
                  <span class="profile-label">Phone</span>
                </div>
                <input type="tel" class="form-input" aria-label="Phone input" />
              </div>
              <div class="profile-row">
                <div class="profile-item">
                  <img loading="lazy" src="https://cdn.builder.io/api/v1/image/assets/TEMP/4bd16cbc188756c619de2382066dab461ca564bcfc1128a74560cc8c9ffc8db0?placeholderIfAbsent=true&apiKey=1dd5640dff5747c98816899eb6d392e1" class="profile-icon" alt="Service icon" />
                  <span class="profile-label">Service</span>
                </div>
                <input type="text" class="form-input" aria-label="Service input" />
              </div>
              <div class="profile-row">
                <div class="profile-item">
                  <img loading="lazy" src="https://cdn.builder.io/api/v1/image/assets/TEMP/6aba804eaa1d8545a85a24c33aef6da56670f1863f755108481ef2d0a86bd07a?placeholderIfAbsent=true&apiKey=1dd5640dff5747c98816899eb6d392e1" class="profile-icon" alt="Manager icon" />
                  <span class="profile-label">Manager</span>
                </div>
                <input type="text" class="form-input" aria-label="Manager input" />
              </div>
            </div>
          </section>
        </div>
      </div>
    </main>
  </template>
  
  <style scoped>
  .profile-view {
    background-color: #fff;
    display: flex;
    flex-direction: column;
    overflow: hidden;
    padding: 20px 30px; 
    width: 1000px;
  }
  
  .profile-container {
    width: 739px;
    max-width: 100%;
  }
  
  .profile-content {
    display: flex;
    gap: 20px;
  }
  
  .profile-info {
    width: 35%;
  }
  
  .profile-details {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    color: #000;
    font: 400 20px Inter, sans-serif;
  }
  
  .profile-title {
    text-shadow: 0 4px 4px rgba(0, 0, 0, 0.25);
    font-size: 30px;
    align-self: flex-start;
  }
  
  .profile-row {
    display: flex;
    align-items: center;
    margin-top: 20px;
  }
  
  .profile-item {
    display: flex;
    align-items: right;
    gap: 10px;
    width: 200px; 
  }
  
  .profile-icon {
    object-fit: contain;
    width: 40px;
  }
  
  .profile-label {
    margin: auto 0;
  }
  
  .form-input {
    border-radius: 10px;
    background-color: #fff;
    box-shadow: 0 4px 4px rgba(0, 0, 0, 0.25);
    height: 45px; 
    border: 1px solid #8d8d8d;
    width: 400px;
  }
  
  @media (max-width: 991px) {
    .profile-view {
      padding: 0 20px;
    }
  
    .profile-content {
      flex-direction: column;
    }
  
    .profile-info {
      width: 100%;
      margin-left: 0;
    }
  
    .profile-details {
      margin-top: 35px;
    }
  
    .form-input {
      margin-bottom: 40px;
      width: 100%; 
    }
  }
  </style>
  
  