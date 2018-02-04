$(function () {
    $.getJSON("../json/market.json", function(json) {
        table= $(".table")
    for(i=0;i<json.market.length;i++){
        $(table).find('tbody').append( "<tr>" );
        $(table).find('tbody').append( "<td>"+json.market[i]["seller"]+"</td>" );
        $(table).find('tbody').append( "<td>"+json.market[i]["name"]+"</td>" );
        $(table).find('tbody').append( "<td>"+json.market[i]["amount"]+"</td>" );
        $(table).find('tbody').append( "<td>"+json.market[i]["Price"]+"</td>" );
        $(table).find('tbody').append("<td><button class='btn-success btn-xs btn'>Buy</button></td>" )
        $(table).find('tbody').append( "</tr>" );
    }

    console.log(json)

    });


});