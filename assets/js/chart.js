import Chart from "../node_modules/chart.js/dist/chart.js"
import ChartDataLabels from "../node_modules/chartjs-plugin-datalabels/dist/chartjs-plugin-datalabels.js"
import "../node_modules/chart.js-plugin-labels-dv/dist/chartjs-plugin-labels.min.js"

const colors = ["#36a2eb"]
const month =
  [
    "Janvier",
    "Février",
    "Mars", 
    "Avril", 
    "Mai", 
    "Juin", 
    "Juillet", 
    "Août", 
    "Septembre", 
    "Octobre", 
    "Novembre", 
    "Décembre", 
  ];

class DoughNutChart {
  constructor(ctx, labels, values) {
    this.chart = new Chart(ctx, {
      type: 'doughnut',
      data: {
        labels: labels,
        datasets: [
          {
            label: "Liste des tâches",
            backgroundColor: colors,
            data: values,
          }
        ]
      },
      options: {
        responsive: true,
        plugins: {
          legend: {
            position: 'top',
          },
          title: {
            display: true,
            text: 'Liste des tâches par contributeurs'
          }
        }
      },
    });
  }
}


class HorizontalBarChart {
  constructor(ctx, labels, values) {
    this.chart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: labels,
        datasets: [
          {
            axis: 'x',
            label: "Liste des tâches",
            data: values,
            fill: false,
            borderColor: colors,
            backgroundColor: colors,
            borderWidth: 1,
            color: '#fff',
          }
        ]
      },
      options: {
        indexAxis: 'x',
        responsive: true,
        plugins: {
          labels: {
            render: 'value',
            fontColor: '#5c5c5c',
            position: 'outside'
          },
          legend: {
            position: 'bottom',
          },
          title: {
            display: true,
            text: 'Liste des tâches par contributeurs'
          },
          datalabels: {
            color: '#fff',
          },
        }
      },
    });
  }
}

class StackedBarChart {
  constructor(ctx, todo_tasks, blocked_tasks, tasks_in_progress, tasks_in_control, achieved_tasks) {
    this.chart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: month,
        datasets: [
          {
            label: "Tâches à faire",
            data: todo_tasks,
            backgroundColor: "#36a2eb",
          },
          {
            label: "Tâches en blocage",
            data: blocked_tasks,
            backgroundColor: "#e67e22",
          },
          {
            label: "Tâches en cours",
            data: tasks_in_progress,
            backgroundColor: "#27ae60",
          },
          {
            label: "Tâches en contrôle",
            data: tasks_in_control,
            backgroundColor: "#8e44ad",
          },
          {
            label: "Tâches achevées",
            data: achieved_tasks,
            backgroundColor: "#ff6384",
          }
        ]
      },
      options: {
        plugins: {
          labels: {
            render: 'value',
            fontColor: '#5c5c5c',
            position: 'outside'
          },
          legend: {
            position: 'bottom',
          },
          title: {
            display: true,
            text: 'Tâches par mois'
          },
        },
        responsive: true,
      },
    });
  }
}

class LineChart {
  constructor(ctx, todo_tasks, blocked_tasks, tasks_in_progress, tasks_in_control, achieved_tasks) {
    this.chart = new Chart(ctx, {
      data: {
        labels: month,
        datasets: [{
          type: 'bar',
          label: "Tâches à faire",
          data: todo_tasks,
          fill: false,
          cubicInterpolationMode: 'monotone',
          tension: 0.4,
          borderColor: "#ff6384",
          backgroundColor: "#ff6384",
        }, {
          type: 'bar',
          label: "Tâches en blockage",
          data: blocked_tasks,
          fill: false,
          cubicInterpolationMode: 'monotone',
          tension: 0.4,
          borderColor: "#36a2eb",
          backgroundColor: "#36a2eb",
        }, {
          type: 'bar',
          label: "Tâches en cours",
          data: tasks_in_progress,
          fill: false,
          cubicInterpolationMode: 'monotone',
          tension: 0.4,
          borderColor: "#36a2eb",
          backgroundColor: "#36a2eb",
        }, {
          type: 'bar',
          label: "Tâches en contrôle",
          data: tasks_in_control,
          fill: false,
          cubicInterpolationMode: 'monotone',
          tension: 0.4,
          borderColor: "#36a2eb",
          backgroundColor: "#36a2eb",
        }, {
          type: 'bar',
          label: "Tâches achevées",
          data: achieved_tasks,
          fill: false,
          cubicInterpolationMode: 'monotone',
          tension: 0.4,
          borderColor: "#36a2eb",
          backgroundColor: "#36a2eb",
        }]
      },
      options: {
        responsive: true,
        plugins: {
          legend: {
            position: 'top',
          },
          title: {
            display: true,
            text: 'Tâches par mois'
          }
        }
      }
    });
  }
}

export { DoughNutChart, HorizontalBarChart, StackedBarChart, LineChart };
