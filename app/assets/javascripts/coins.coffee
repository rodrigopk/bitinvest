ready = ->
  #console.log $('#coin_chart').data('label')

  $('#coin_chart').highcharts 'StockChart',
    chart: type: 'line'
    
    rangeSelector:
      allButtonsEnabled: true
      buttons: [
        {
          type: 'hour'
          count: 1
          text: 'Hour'
        }
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
      selected: 2

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
