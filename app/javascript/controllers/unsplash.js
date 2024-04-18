
  document.addEventListener("turbo:load", function() {
    const searchInput = document.querySelector("[data-search-tasks-target='query']");
    const tasksList = document.getElementById('tasks-list');

    searchInput.addEventListener('keyup', function() {
      const query = this.value.toLowerCase();
      const tasks = tasksList.querySelectorAll('.task-card');

      tasks.forEach(function(task) {
        const taskName = task.querySelector('.task-name').innerText.toLowerCase();
        const backgroundImage = `https://source.unsplash.com/featured/?${encodeURIComponent(taskName)}`;
        task.style.backgroundImage = `url(${backgroundImage})`;
      });
    });
  });
