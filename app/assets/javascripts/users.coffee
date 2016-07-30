ready = ->
  #console.log $('#user_chart').data('label')

  $('#user_chart').highcharts 'StockChart',
    chart: type: 'line'
    rangeSelector:
      allButtonsEnabled: true
      buttons: [
        {
          type: 'hour'
          count: 24
          text: 'Day'
        }
        {
          type: 'all'
          text: 'Week'
        }
      ]
      buttonTheme: width: 60
      selected: 1

    title: text: $('#user_chart').data('title')

    yAxis: title: text: $('#user_chart').data('label')
    series: [
      {
        name: 'value'
        data: $('#user_chart').data('values')
        tooltip: {
                    valueDecimals: 2
                }
      }
    ]
  return

$(document).ready(ready)
$(document).on('page:load', ready)