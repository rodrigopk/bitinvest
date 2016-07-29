ready = ->
  #console.log $('#user_chart').data('label')

  $('#user_chart').highcharts 'StockChart',
    chart: type: 'line'
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