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
          dataGrouping:
            forced: true
            units: [ [
              'hour'
              [ 4 ]
            ] ]
        }
        {
          type: 'hour'
          count: 24
          text: 'Day'
          dataGrouping:
            forced: true
            units: [ [
              'hour'
              [ 4 ]
            ] ]
        }
        {
          type: 'all'
          text: 'Week'
          dataGrouping:
            forced: true
            units: [ [
              'hour'
              [ 4 ]
            ] ]
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
