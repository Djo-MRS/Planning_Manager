<template>
    <section class="help-view">
      <div class="help-container">
        <h1 class="help-title">FAQ</h1>
        <form class="help-form">
          <div class="question-answer-group">
            <div class="input-group">
              <label for="question1" class="input-label">Question 1: How do I use this item?</label>
              <input id="question1" type="text" class="input-field" placeholder="Type here..." />
              <span class="error-message">Type an error message</span>
            </div>
            <div class="input-group">
              <label for="answer1" class="input-label">Answer 1: Click on submit.</label>
              <input id="answer1" type="text" class="input-field" placeholder="Type here..." />
              <span class="error-message">Type an error message</span>
            </div>
          </div>
          <div class="question-answer-group">
            <div class="input-group">
              <label for="question2" class="input-label">Question 2: ...</label>
              <input id="question2" type="text" class="input-field" placeholder="Type here..." />
              <span class="error-message">Type an error message</span>
            </div>
            <div class="input-group">
              <label for="answer2" class="input-label">Answer 2: ...</label>
              <input id="answer2" type="text" class="input-field" placeholder="Type here..." />
              <span class="error-message">Type an error message</span>
            </div>
          </div>
          <div class="input-group">
            <label for="userQuestion" class="input-label">Enter your question here:</label>
            <input id="userQuestion" type="text" class="input-field" placeholder="Type here..." />
            <span class="error-message">Type an error message</span>
          </div>
          <div class="input-group">
            <label for="userEmail" class="input-label">Enter your email address (optional)</label>
            <input id="userEmail" type="email" class="input-field" placeholder="example@email.com" />
            <span class="error-message">Type an error message</span>
          </div>
          <button type="submit" class="submit-button">
            Submit
            <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/240f63fefbf307ccbc5e2b7d3d61746bad14850499abc5aa060cd2f1b2e1fce5?placeholderIfAbsent=true&apiKey=1dd5640dff5747c98816899eb6d392e1" alt="" class="submit-icon" />
          </button>
        </form>
      </div>
      <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/cf1a03ae3976cc9afbbcebd28a20ae2e151a148562fd76b6fa8d0e3e45865f3c?placeholderIfAbsent=true&apiKey=1dd5640dff5747c98816899eb6d392e1" alt="" class="footer-image" />
    </section>
  </template>
  
  <style scoped>
  .help-view {
    background-color: #fff;
    display: flex;
    flex-direction: column;
    overflow: hidden;
    padding: 97px 0;
  }
  
  .help-container {
    display: flex;
    width: 100%;
    flex-direction: column;
    padding: 0 20px;
  }
  
  .help-title {
    color: #000;
    text-shadow: 0 4px 4px rgba(0, 0, 0, 0.25);
    align-self: flex-start;
    margin-left: 68px;
    font: 40px Inter, sans-serif;
  }
  
  .help-form {
    background-color: #fff;
    box-shadow: 0 1px 4px rgba(0, 0, 0, 0.16);
    display: flex;
    margin-top: 35px;
    width: 100%;
    flex-direction: column;
    align-items: flex-start;
    font-family: Instrument Sans, sans-serif;
    color: var(--light-input-color, #000);
    padding: 19px 80px 19px 36px;
  }
  
  .question-answer-group {
    display: flex;
    width: 100%;
    max-width: 1423px;
    flex-direction: column;
    justify-content: flex-start;
  }
  
  .input-group {
    display: flex;
    width: 100%;
    max-width: 1423px;
    flex-direction: column;
    justify-content: flex-start;
    margin-top: 23px;
  }
  
  .input-label {
    font-size: 20px;
  }
  
  .input-field {
    align-self: stretch;
    flex: 1;
    border: none;
    border-bottom: 1px solid var(--light-border-color, rgba(0, 32, 128, 0.2));
    margin-top: 12px;
    min-height: 40px;
    width: 100%;
    font-size: 16px;
    padding: 0 4px;
  }
  
  .error-message {
    color: var(--light-error-color, #ff4b4b);
    font-size: 12px;
    margin-top: 12px;
  }
  
  .submit-button {
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 8px;
    background: var(--light-accent-color, #853ff9);
    margin-top: 56px;
    gap: 10px;
    font-size: 14px;
    color: #fff;
    font-weight: 600;
    padding: 10px 16px 10px 20px;
    border: none;
    cursor: pointer;
  }
  
  .submit-icon {
    width: 13px;
    height: 13px;
    object-fit: contain;
  }
  
  .footer-image {
    aspect-ratio: 6.1;
    object-fit: contain;
    width: 366px;
    align-self: center;
    margin-top: 88px;
    max-width: 100%;
  }
  
  @media (max-width: 991px) {
    .help-view {
      padding-bottom: 100px;
    }
  
    .help-container {
      max-width: 100%;
    }
  
    .help-title {
      margin-left: 10px;
    }
  
    .help-form {
      max-width: 100%;
      padding: 0 20px;
    }
  
    .question-answer-group,
    .input-group {
      max-width: 100%;
    }
  
    .submit-button {
      margin-top: 40px;
      white-space: normal;
    }
  
    .footer-image {
      margin-top: 40px;
    }
  }
  </style>