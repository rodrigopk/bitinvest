ready = ->
  #console.log $('#coin_chart').data('label')

  $('#coin_chart').highcharts 'StockChart',
    chart: type: 'line'
    title: text: $('#coin_chart').data('title')

    yAxis: title: text: $('#coin_chart').data('label')
    series: [
      {
        name: 'value'
        data: $('#coin_chart').data('values')
        tooltip: {
                    valueDecimals: 8
                }
      }
    ]
  return

$(document).ready(ready)
$(document).on('page:load', ready)
