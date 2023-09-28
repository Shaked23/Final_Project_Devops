<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Random Quote Generator</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Roboto', sans-serif;
      background: linear-gradient(135deg, #FFD9E3, #FFB6C1);
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      transition: background-color 0.5s;
    }

    #quote-container {
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      padding: 20px;
      text-align: center;
    }

    h1 {
      color: #FF1493;
      font-size: 28px;
      margin-bottom: 20px;
    }

    #quote-text {
      font-size: 20px;
      margin-bottom: 20px;
      white-space: pre-line;
      overflow: hidden;
      border-right: 2px solid #FF1493;
      padding-right: 10px;
      animation: typing 5s steps(40) forwards;
    }

    #quote-author {
      font-size: 16px;
      color: #888;
    }

    button {
      padding: 12px 24px;
      font-size: 16px;
      background-color: #FF1493;
      color: #fff;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease-in-out;
      margin-right: 10px;
    }

    button:hover {
      background-color: #FF007F;
    }

    .share-buttons {
      margin-top: 20px;
    }

    .share-button {
      background-color: #007BFF;
      color: #fff;
      border: none;
      border-radius: 5px;
      padding: 12px 24px;
      margin-right: 10px;
      cursor: pointer;
      transition: background-color 0.3s ease-in-out;
    }

    .share-button:hover {
      background-color: #0056b3;
    }

    @keyframes typing {
      from {
        width: 0;
      }
      to {
        width: 100%;
      }
    }

    /* Additional Styles */
    .quote-actions {
      display: flex;
      justify-content: center;
      align-items: center;
      margin-top: 20px;
    }

    .quote-actions button {
      margin-right: 10px;
    }
  </style>

  <!-- Open Graph meta tags for Facebook sharing -->
  <meta property="og:title" content="Random Quote Generator">
  <meta property="og:description" content="Get inspired by a random quote">
  <meta property="og:image" content="https://your-website-url.com/your-image.jpg">
</head>
<body>
<div id="quote-container">
  <h1>Test Random Quote Generator</h1>
  <p id="quote-text">Click the button to get a random quote.</p>
  <p id="quote-author"></p>
  <button id="get-quote">Get Quote</button>

  <div class="quote-actions">
    <button class="share-button" id="share-facebook">Share on Facebook</button>
    <button id="color-change">Change Background Color</button>
  </div>
</div>

<script>
  let isAnimating = false;

  // Function to fetch and display a random quote
  function getRandomQuote() {
    if (!isAnimating) {
      isAnimating = true;
      document.getElementById("quote-text").textContent = "";
      document.getElementById("quote-author").textContent = "";
      fetch(`https://api.quotable.io/random`)
              .then(response => response.json())
              .then(data => {
                const quote = data.content;
                const author = data.author;
                animateText(quote, author);
              })
              .catch(error => {
                console.error("Error fetching quote:", error);
              });
    }
  }

  // Function to animate text
  function animateText(text, author) {
    const quoteTextElement = document.getElementById("quote-text");
    const quoteAuthorElement = document.getElementById("quote-author");

    let index = 0;
    const interval = setInterval(function() {
      if (index < text.length) {
        quoteTextElement.textContent += text.charAt(index);
        index++;
      } else {
        clearInterval(interval);
        isAnimating = false;
        quoteAuthorElement.textContent = `- ${author}`;
      }
    }, 50); // Adjust the animation speed here
  }

  document.getElementById("get-quote").addEventListener("click", getRandomQuote);

  document.getElementById("share-facebook").addEventListener("click", function() {
    const quote = document.getElementById("quote-text").textContent;
    const facebookUrl = `https://www.facebook.com/sharer/sharer.php}`;
    window.open(facebookUrl, '_blank');
  });

  // Random background color
  document.getElementById("color-change").addEventListener("click", function() {
    const randomColor = getRandomColor();
    document.body.style.background = randomColor;
    document.getElementById("color-change").textContent = `Change Background Color (${randomColor})`;
  });

  function getRandomColor() {
    const letters = "0123456789ABCDEF";
    let color = "#";
    for (let i = 0; i < 6; i++) {
      color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
  }

  // Initial quote fetch
  getRandomQuote();
</script>
</body>
</html>
