local Licenses = {
    ["Dev"] = {
        ["11462f7bb66a21f3b66102cb8a5ad97f09b5a323"] = true, -- leitao
    },
    ["Admin2"] = {
        ["SUA LICENSA AQUI"] = true,
    },
    ["God"] = {
        ["11462f7bb66a21f3b66102cb8a5ad97f09b5a323"] = true, -- lincoln
    },
    ["QA"] = {
        ["SUA LICENSA AQUI"] = true,
    },
    ["Rem"] = {
        ["SUA LICENSA AQUI"] = true,
    }
}

exports("GetLicenses",function(licenseType)
    if Licenses[licenseType] then
        return Licenses[licenseType]
    else
        return nil
    end
end)