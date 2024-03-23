// Function to trigger confetti effect
function triggerConfetti() {
  // Configuration options for confetti effect
  var config = {
    angle: 90,
    spread: 45,
    particleCount: 100,
    origin: { y: 0.6 }
  };

  // Trigger the confetti effect
  confetti.create(undefined, config);
}

// Add event listener to the "Begin journey" button to trigger confetti effect on click
document.getElementById('begin-journey-btn button').addEventListener('click', function() {
  triggerConfetti();
});
