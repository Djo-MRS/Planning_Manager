<template>
    <section class="help-view">
      <div class="help-container">
        <h1 class="help-title">FAQ</h1>
        <form class="help-form">
          <div class="question-answer-group">
            <div class="input-group">
              <label for="question1" class="input-label">Q1: How to use?</label>
            </div>
            <div class="input-group">
              <label for="answer1" class="input-label">A1: Click submit.</label>
            </div>
          </div>
          <div class="question-answer-group">
            <div class="input-group">
              <label for="question2" class="input-label">Q2: ...</label>
            </div>
            <div class="input-group">
              <label for="answer2" class="input-label">A2: ...</label>
            </div>
          </div>
          <div class="input-group">
            <label for="userQuestion" class="input-label">Your question:</label>
            <input id="userQuestion" type="text" class="input-field" placeholder="Type here..." />
          </div>
          <div class="input-group">
            <label for="userEmail" class="input-label">Your email:</label>
            <input id="userEmail" type="email" class="input-field" placeholder="example@email.com" />
          </div>
          <button type="submit" class="submit-button">
            Submit
            <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/240f63fefbf307ccbc5e2b7d3d61746bad14850499abc5aa060cd2f1b2e1fce5?placeholderIfAbsent=true&apiKey=1dd5640dff5747c98816899eb6d392e1" alt="" class="submit-icon" />
          </button>
        </form>
      </div>
    </section>
  </template>
  
  <style scoped>
  .help-view {
    background-color: #fff;
    display: flex;
    flex-direction: column;
    overflow: hidden;
    padding: 10px 20px; 
    height: 600px; 
  }
  
  .help-container {
    display: flex;
    flex-direction: column;
    width: 100%;
    padding: 0;
  }
  
  .help-title {
    color: #000;
    font-size: 24px; 
    margin-bottom: 10px; 
  }
  
  .help-form {
    background-color: #fff;
    box-shadow: 0 1px 4px rgba(0, 0, 0, 0.16);
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    padding: 10px 20px; 
    width: 100%;
    height: 100%; 
  }
  
  .input-group {
    display: flex;
    flex-direction: column;
    width: 100%;
    margin-top: 10px; 
  }
  
  .input-label {
    font-size: 14px; 
  }
  
  .input-field {
    border: none;
    border-bottom: 1px solid rgba(0, 32, 128, 0.2);
    margin-top: 5px; 
    min-height: 30px; 
    width: 100%;
    font-size: 14px; 
    padding: 0 4px;
  }
  
  .submit-button {
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 8px;
    background: #853ff9; 
    margin-top: 20px; 
    font-size: 14px; 
    color: #fff;
    padding: 8px 12px;
    border: none;
    cursor: pointer;
  }
  
  .submit-icon {
    width: 13px;
    height: 13px;
  }
  
  .footer-image {
    max-width: 100%;
    margin-top: 20px;
  }
  
  @media (max-width: 600px) {
    .help-title {
      font-size: 20px; 
    }
  
    .input-label {
      font-size: 12px; 
    }
  
    .input-field {
      font-size: 12px; 
    }
  
    .submit-button {
      font-size: 12px; 
    }
  }
  </style>
  