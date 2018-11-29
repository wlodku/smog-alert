// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require Chart.min
//= require social-share-button
// require lodash
// require jquery.countdown
// require jquery.countdown-es
// require turbolinks
//= require_tree .

// $(function() {
//   let ijp = $('#ijp');
//   let ijpval = $('#ijp-value').html();
//   ijpval = parseInt(ijpval);
//
//
//   if(ijpval < 1) {
//     ijp.addClass('w3-blue');
//   }
//   if(ijpval > 0 && ijpval < 3) {
//     ijp.addClass('w3-green');
//   }
//   if(ijpval > 2 && ijpval < 5) {
//     ijp.addClass('w3-yellow');
//   }
//   if(ijpval > 4 && ijpval < 7) {
//     ijp.addClass('w3-orange');
//   }
//   if(ijpval > 6 && ijpval < 11) {
//     ijp.addClass('w3-red');
//   }
//   if(ijpval > 10) {
//     ijp.addClass('w3-purple');
//   }
//   // console.log(ijpval);
//
//
//
// });


document.addEventListener("DOMContentLoaded", function(event) {



  var cd = new Countdown({
      cont: document.querySelector('#counter'),
      endDate: 1640995199000,
      outputTranslation: {
          year: 'Lata',
          week: 'Tygodnie',
          day: 'Dni',
          hour: 'Godziny',
          minute: 'Minuty',
          second: 'Sekundy',
      },
      endCallback: null,
      outputFormat: 'year|day|hour|minute|second',
  });
  cd.start();
  // let countDownDate = new Date("Dec 31, 2021 23:59:59").getTime();
  // let x = setInterval(function() {
  //
  //
  //   let now = new Date().getTime();
  //
  //
  //   let distance = countDownDate - now;
  //
  //   let full_days = Math.floor(distance / (1000 * 60 * 60 * 24));
  //   let years = Math.floor(full_days / 365);
  //   let days = full_days % 365;
  //   let hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  //   let minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
  //   let seconds = Math.floor((distance % (1000 * 60)) / 1000);
  //
  //
  //   document.getElementById("counter").innerHTML = years + " lata " + days + " dni " + hours + " h " + minutes + " m " + seconds + " s ";
  //
  //   if (distance < 0) {
  //     clearInterval(x);
  //     document.getElementById("demo").innerHTML = "bum xD";
  //   }
  // }, 1000);

});

function monthly_chart() {
  const datasets = [];
  for (var i = 2; i < arguments.length; i+=2) {
    let color = 'rgba(' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ', 1)';
    let obj =  {
      label: arguments[i],
      data: arguments[i+1],
      // hidden: i<7 ? false : true,
      backgroundColor: [
          'rgba(0,0,0,0)',
      ],
      borderColor: [
          color,
      ],
      borderWidth: 1,
      fill: false
    }
    datasets.push(obj)
  }


  let pm10 = {
      label: '100% wg WHO',
      data: [50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50],
      backgroundColor: [
          'rgba(255, 99, 132, 0.1)'
      ],
      borderColor: [
          'rgba(255,99,132,1)'
      ],
      borderWidth: 1,
      pointRadius: 0
  }
  datasets.push(pm10);

  console.log(datasets);

  var ctx = document.getElementById(arguments[0]).getContext('2d');
  var myChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: arguments[1],
        datasets: datasets
    },
    options: {
        scales: {
            yAxes: [{
                scaleLabel: {
                  display: true,
                  labelString: 'ug/m3'
                },
                ticks: {
                    beginAtZero:true
                },

            }],
            xAxes: [
            {
              scaleLabel: {
                display: true,
                labelString: 'Dzień stycznia'
              },
            }
            ],
        },
        legend: {
          position:'right'
        }
    }
  });
}


function live() {
  const datasets = [];
  for (var i = 2; i < arguments.length; i+=2) {
    let color = 'rgba(' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ', 1)';
    let obj =  {
      label: arguments[i],
      data: arguments[i+1],
      hidden: i<7 ? false : true,
      backgroundColor: [
          'rgba(0,0,0,0)',
      ],
      borderColor: [
          color,
      ],
      borderWidth: 1,
      fill: false
    }
    datasets.push(obj)
  }


  let pm10 = {
      label: '100% wg WHO',
      data: [50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50],
      backgroundColor: [
          'rgba(255, 99, 132, 0.1)'
      ],
      borderColor: [
          'rgba(255,99,132,1)'
      ],
      borderWidth: 1,
      pointRadius: 0
  }
  datasets.push(pm10);


  // var ctx = document.getElementById(arguments[0]).getContext('2d');
  var ctx = 'live';
  var myChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: arguments[1],
        datasets: datasets
    },
    options: {
        scales: {
            yAxes: [{
                scaleLabel: {
                  display: true,
                  labelString: 'ug/m3'
                },
                ticks: {
                    beginAtZero:true
                },

            }],
            xAxes: [
            {
              scaleLabel: {
                display: true,
                labelString: 'godziny'
              },
            }
            ],
        },
        legend: {
          position:'right'
        }
    }
  });
}

//pm10 jaworzno comparision
function live(mes, canvasId) {
  console.log(arguments);
  const datasets = [];
  for (let i = 2; i < mes.length; i+=2) {
    let color = 'rgba(' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ', 1)';
    let obj =  {
      label: mes[i],
      data: mes[i+1],
      // hidden: i<7 ? false : true,
      hidden: false,
      backgroundColor: [
          'rgba(0,0,0,0)',
      ],
      borderColor: [
          color,
      ],
      borderWidth: 1,
      fill: false
    }
    datasets.push(obj)
  }


  let pm10 = {
      label: '100% wg WHO',
      data: [50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50],
      backgroundColor: [
          'rgba(255, 99, 132, 0.1)'
      ],
      borderColor: [
          'rgba(255,99,132,1)'
      ],
      borderWidth: 1,
      pointRadius: 0
  }
  datasets.push(pm10);

  // console.log(datasets);

  var ctx = canvasId;
  var myChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: mes[1],
        datasets: datasets
    },
    options: {
        scales: {
            yAxes: [{
                scaleLabel: {
                  display: true,
                  labelString: 'ug/m3'
                },
                ticks: {
                    beginAtZero:true
                },

            }],
            xAxes: [
            {
              scaleLabel: {
                display: true,
                labelString: 'godziny'
              },
            }
            ],
        },
        legend: {
          position:'right'
        }
    }
  });
}



function area(canvasId, labels, pm10, pm25) {
  var ctx = document.getElementById(canvasId).getContext('2d');
  var myChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: labels,
        datasets: [
        {
            label: "PM10",
            data: pm10,
            backgroundColor: [
                'rgba(255, 99, 132, 0)',
            ],
            borderColor: [
                'rgba(230, 25, 75,1)',
            ],
            borderWidth: 2,
            fill: false
        },
        {
            label: "PM2.5",
            data: pm25,
            backgroundColor: [
                'rgba(54, 162, 235, 0)',
            ],
            borderColor: [
                'rgba(54, 162, 235, 1)',
            ],
            borderWidth: 2,
            fill: false
        },
        {
            label: 'Wartość dopuszczalna PM10 [50ug/m3]',
            data: [50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50],
            backgroundColor: [
                // 'rgba(255, 99, 132, 0.1)',
                // 'rgba(54, 162, 235, 0.2)',
                // 'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0)'

            ],
            borderColor: [
              'rgba(230, 25, 75,1)'
            ],
            borderWidth: 1,
            pointRadius: 0
        },
        {
            label: 'Wartość dopuszczalna PM2.5 [25ug/m3]',
            data: [25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25],
            backgroundColor: [
                // 'rgba(255, 99, 132, 0.1)',
                // 'rgba(54, 162, 235, 0.2)',
                // 'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0)'

            ],
            borderColor: [
              'rgba(54, 162, 235, 1)',
            ],
            borderWidth: 1,
            pointRadius: 0
        }
      ]
    },
    options: {
        scales: {
            yAxes: [{
                scaleLabel: {
                  display: true,
                  labelString: '[ug/m3]'
                },
                ticks: {
                    beginAtZero:true
                },

            }],
            xAxes: [
            {
              scaleLabel: {
                display: true,
                labelString: 'godziny'
              },
            }
            ],
        },
        legend: {
          position:'top'
        }
    }
  });
}




  function looko2(canvasId, labels, data10, data25) {
    var ctx = document.getElementById(canvasId).getContext('2d');
    var myChart = new Chart(ctx, {
      type: 'line',
      data: {
          labels: labels,
          datasets: [{
              label: 'PM10 (ug/m3)',
              data: data10,
              backgroundColor: [
                  'rgba(255, 99, 132, 0)'
                  // 'rgba(54, 162, 235, 0.2)',
                  // 'rgba(255, 206, 86, 0.2)',
                  // 'rgba(75, 192, 192, 0.2)',
                  // 'rgba(153, 102, 255, 0.2)',
                  // 'rgba(255, 159, 64, 0.2)'
              ],
              borderColor: [
                  'rgba(255,99,132,1)'
                  // 'rgba(54, 162, 235, 1)',
                  // 'rgba(255, 206, 86, 1)',
                  // 'rgba(75, 192, 192, 1)',
                  // 'rgba(153, 102, 255, 1)',
                  // 'rgba(255, 159, 64, 1)'
              ],
              borderWidth: 1,
              fill: false
          },
          {
              label: 'PM25 (ug/m3)',
              data: data25,
              backgroundColor: [
                  // 'rgba(255, 99, 132, 0.2)',
                  'rgba(54, 162, 235, 0)'
                  // 'rgba(255, 206, 86, 0.2)',
                  // 'rgba(75, 192, 192, 0.2)',
                  // 'rgba(153, 102, 255, 0.2)',
                  // 'rgba(255, 159, 64, 0.2)'
              ],
              borderColor: [
                  // 'rgba(255,99,132,1)',
                  'rgba(54, 162, 235, 1)'
                  // 'rgba(255, 206, 86, 1)',
                  // 'rgba(75, 192, 192, 1)',
                  // 'rgba(153, 102, 255, 1)',
                  // 'rgba(255, 159, 64, 1)'
              ],
              borderWidth: 1,
              fill: false
          },
          {
              label: 'Wartość dopuszczalna PM10(ug/m3) na dobę',
              data: [50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50],
              backgroundColor: [
                  'rgba(255, 99, 132, 0.1)'
                  // 'rgba(54, 162, 235, 0.2)',
                  // 'rgba(255, 206, 86, 0.2)',
                  // 'rgba(75, 192, 192, 0.2)',
                  // 'rgba(153, 102, 255, 0.2)',
                  // 'rgba(255, 159, 64, 0.2)'
              ],
              borderColor: [
                  'rgba(255,99,132,1)'
                  // 'rgba(54, 162, 235, 1)',
                  // 'rgba(255, 206, 86, 1)',
                  // 'rgba(75, 192, 192, 1)',
                  // 'rgba(153, 102, 255, 1)',
                  // 'rgba(255, 159, 64, 1)'
              ],
              borderWidth: 1,
              pointRadius: 0
          }
          // {
          //     label: 'Wartość dopuszczalna PM2.5(ug/m3) na dobę',
          //     data: [25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25],
          //     backgroundColor: [
          //         // 'rgba(255, 99, 132, 0.1)',
          //         // 'rgba(54, 162, 235, 0.2)',
          //         // 'rgba(255, 206, 86, 0.2)',
          //         'rgba(75, 192, 192, 0.1)',
          //         'rgba(153, 102, 255, 0.2)',
          //         'rgba(255, 159, 64, 0.2)'
          //     ],
          //     borderColor: [
          //         // 'rgba(255,99,132,1)',
          //         // 'rgba(54, 162, 235, 1)',
          //         // 'rgba(255, 206, 86, 1)',
          //         'rgba(75, 192, 192, 1)',
          //         'rgba(153, 102, 255, 1)',
          //         'rgba(255, 159, 64, 1)'
          //     ],
          //     borderWidth: 1,
          //     pointRadius: 0
          // }

        ]
      },
      options: {
          scales: {
              yAxes: [{
                  ticks: {
                      beginAtZero:true
                  }
              }]
          }
      }
    });
  }

  function pm10_report(canvasId, numberOfDays, data) {
    var ctx = document.getElementById(canvasId).getContext('2d');
    var myChart = new Chart(ctx, {
      type: 'line',
      data: {
          labels: [...Array.from(new Array(numberOfDays), (x,i) => i+1)],
          datasets: [{
              label: 'PM10 (ug/m3)',
              data: data,
              backgroundColor: [
                  'rgba(255, 99, 132, 0.2)'
                  // 'rgba(54, 162, 235, 0.2)',
                  // 'rgba(255, 206, 86, 0.2)',
                  // 'rgba(75, 192, 192, 0.2)',
                  // 'rgba(153, 102, 255, 0.2)',
                  // 'rgba(255, 159, 64, 0.2)'
              ],
              borderColor: [
                  'rgba(255,99,132,1)'
                  // 'rgba(54, 162, 235, 1)',
                  // 'rgba(255, 206, 86, 1)',
                  // 'rgba(75, 192, 192, 1)',
                  // 'rgba(153, 102, 255, 1)',
                  // 'rgba(255, 159, 64, 1)'
              ],
              borderWidth: 1,
              fill: false
          },
          {
              label: 'Wartość dopuszczalna (ug/m3)',
              data: [...Array.from(new Array(numberOfDays), (x,i) => 50)],
              backgroundColor: [
                  // 'rgba(255, 99, 132, 0.2)',
                  // 'rgba(54, 162, 235, 0.2)',
                  // 'rgba(255, 206, 86, 0.2)',
                  'rgba(75, 192, 192, 0.2)'
                  // 'rgba(153, 102, 255, 0.2)',
                  // 'rgba(255, 159, 64, 0.2)'
              ],
              borderColor: [
                  // 'rgba(255,99,132,1)',
                  // 'rgba(54, 162, 235, 1)',
                  // 'rgba(255, 206, 86, 1)',
                  'rgba(75, 192, 192, 1)'
                  // 'rgba(153, 102, 255, 1)',
                  // 'rgba(255, 159, 64, 1)'
              ],
              borderWidth: 1,
              pointRadius: 0
          }
          ]
      },
      options: {
          scales: {
            xAxes: [
            {
              scaleLabel: {
                display: true,
                labelString: 'Dzień miesiąca'
              },
            }],
              yAxes: [{
                scaleLabel: {
                  display: true,
                  labelString: 'ug/m3'
                },
                  ticks: {
                      beginAtZero:true
                  }
              }]
          }
      }
    });
  }

  function pm25_report(canvasId, numberOfDays, data) {
    var ctx = document.getElementById(canvasId).getContext('2d');
    var myChart = new Chart(ctx, {
      type: 'line',
      data: {
          labels: [...Array.from(new Array(numberOfDays), (x,i) => i+1)],
          datasets: [{
              label: 'PM2.5 (ug/m3)',
              data: data,
              backgroundColor: [
                  'rgba(255, 99, 132, 0.2)'
                  // 'rgba(54, 162, 235, 0.2)',
                  // 'rgba(255, 206, 86, 0.2)',
                  // 'rgba(75, 192, 192, 0.2)',
                  // 'rgba(153, 102, 255, 0.2)',
                  // 'rgba(255, 159, 64, 0.2)'
              ],
              borderColor: [
                  'rgba(255,99,132,1)'
                  // 'rgba(54, 162, 235, 1)',
                  // 'rgba(255, 206, 86, 1)',
                  // 'rgba(75, 192, 192, 1)',
                  // 'rgba(153, 102, 255, 1)',
                  // 'rgba(255, 159, 64, 1)'
              ],
              borderWidth: 1,
              fill: false
          },
          {
              label: 'Wartość dopuszczalna (ug/m3)',
              data: [...Array.from(new Array(numberOfDays), (x,i) => 25)],
              backgroundColor: [
                  // 'rgba(255, 99, 132, 0.2)',
                  'rgba(54, 162, 235, 0.2)'
                  // 'rgba(255, 206, 86, 0.2)',
                  // 'rgba(75, 192, 192, 0.2)',
                  // 'rgba(153, 102, 255, 0.2)',
                  // 'rgba(255, 159, 64, 0.2)'
              ],
              borderColor: [
                  // 'rgba(255,99,132,1)',
                  // 'rgba(54, 162, 235, 1)',
                  // 'rgba(255, 206, 86, 1)',
                  'rgba(75, 192, 192, 1)'
                  // 'rgba(153, 102, 255, 1)',
                  // 'rgba(255, 159, 64, 1)'
              ],
              borderWidth: 1,
              pointRadius: 0
          }
          ]
      },
      options: {
          scales: {
            xAxes: [
            {
              scaleLabel: {
                display: true,
                labelString: 'Dzień miesiąca'
              },
            }],
              yAxes: [{
                scaleLabel: {
                  display: true,
                  labelString: 'ug/m3'
                },
                  ticks: {
                      beginAtZero:true
                  }
              }]
          }
      }
    });
  }
