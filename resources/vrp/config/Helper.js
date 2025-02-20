const regexValidHwidToken = /^[0-9A-Fa-f]{1,2}:[0-9A-Fa-f]{64}$/;

const filterPlayerHwids = (hwids) => {
    if (!Array.isArray(hwids)) {
        throw new TypeError('Expected an array of HWIDs');
    }

    let invalidHwidsArray = [];
    let validHwidsArray = [];

    for (const hwidString of hwids) {
        if (typeof hwidString !== 'string') continue;
        if (regexValidHwidToken.test(hwidString)) {
            validHwidsArray.push(hwidString);
        } else {
            invalidHwidsArray.push(hwidString);
        }
    }

    return { invalidHwidsArray, validHwidsArray };
};

exports("filterPlayerHwids", (hwids) => {
    return filterPlayerHwids(hwids)
});