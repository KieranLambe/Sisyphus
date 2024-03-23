document.addEventListener('DOMContentLoaded', function() {
  var ctx = document.getElementById('pieChart').getContext('2d');

  // Generate random percentages for the pie chart
  var labels = ['Music', 'Cooking', 'Reading', 'Exercise'];
  var percentages = [];
  for (var i = 0; i < labels.length; i++) {
    percentages.push(Math.floor(Math.random() * 100) + 1);
  }

  var pieChart = new Chart(ctx, {
    type: 'pie',
    data: {
      labels: labels,
      datasets: [{
        data: percentages,
        backgroundColor: [
          'rgba(255, 99, 132, 0.5)',
          'rgba(54, 162, 235, 0.5)',
          'rgba(255, 206, 86, 0.5)',
          'rgba(75, 192, 192, 0.5)'
        ],
        borderWidth: 1
      }]
    },
    options: {
      // Add options here for customization
      // Example: title, legend, etc.
    }
  });
});
