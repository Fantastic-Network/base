function timeConverter(UNIX_timestamp){
    var a = new Date(UNIX_timestamp * 1000);
    var year = a.getFullYear();
    var month = a.getMonth();
    var day = a.getDate();
    var hour = a.getHours();
    var min = a.getMinutes();
    var sec = a.getSeconds();
    return { day, month, year, hour, min, sec };
}

exports("getDate", (UNIX_timestamp) => {
    return timeConverter(UNIX_timestamp)
});