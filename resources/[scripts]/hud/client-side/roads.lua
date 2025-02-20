cityName = GetConvar("cityName", "Base")

Streets = {
    -- { hash = 0, name = "" },
    -- { hash = -1650229529, name = "Av. Roberto Carlos" },
    -- { hash = 1679357694, name = "Av L. Hunsche" },
    -- { hash = -1804608311, name = "R. Quatro" },
    -- { hash = -1791978259, name = "R. Clodomiro Pinheiro" },
    -- { hash = -1830698864, name = "R. Ouro Verde" },
    -- { hash = -1872020078, name = "R. Arvore da Cera" },
    -- { hash = 567258876, name = "R. Acioli Monteiro" },
    -- { hash = -744494798, name = "R. Antônio Mariani" },
    -- { hash = 2126748386, name = "R. Tiburno" },
    -- { hash = 916897355, name = "R. Venceslau" },
    -- { hash = 853093701, name = "R. Rubens" },
    -- { hash = 1676954661, name = "R. Cravo do Campo" },
    -- { hash = -566765044, name = "R. Itacaranha" },
    -- { hash = 358596139, name = "R. Hercí­lio Luz" },
    -- { hash = 1497974009, name = "R. Xororó" },
    -- { hash = 173801282, name = "R. Monteiro Lobato" },
    -- { hash = -1217521905, name = "R. Banana-Branca" },
    -- { hash = -182884461, name = "R. Nova Olinda" },
    -- { hash = 1401592080, name = "R. Paolo Porpora" },
    -- { hash = 609524159, name = "R. Angélicas" },
    -- { hash = -364774424, name = "R. Belfort Roxo" },
    -- { hash = -1694381789, name = "Est. Base" }, 
    -- { hash = 127506487, name = "R. Alto Base Maria" },
    -- { hash = -1398838962, name = "Est. Base" },
    -- { hash = 4155137, name = "Av. Skorpion" },
    -- { hash = -168827017, name = "R. Durval de Almeida" },
    -- { hash = -583776065, name = "R. Hemisfério" },
    -- { hash = 1670951541, name = "R. Cesare Badiali" },
    -- { hash = -2047518581, name = "R. Charles Naufal" },
    -- { hash = 1245123266, name = "R. Firmino" },
    -- { hash = -720113662, name = "R. Crispo" },
    -- { hash = 422479126, name = "Est. Grande" },
    -- { hash = -169974511, name = "R. Luís Morales" },
    -- { hash = -945210448, name = "Praça Ocupação" },
    -- { hash = -1502208605, name = "R. da Independência" },
    -- { hash = 1224796925, name = "Av. Tribo" },
    -- { hash = -1728734423, name = "R. Carlos Reis" },
    -- { hash = 1305375448, name = "Av. Paulista" }, 
    -- { hash = -994079839, name = "R. Anael" },
    -- { hash = 825407909, name = "R. Ribeirão Pires" },
    -- { hash = -409785781, name = "R. Roberto Firmino" },
    -- { hash = 648011493, name = "R. Caçador Narciso" },
    -- { hash = 1520509920, name = "R. Manilha" },
    -- { hash = 954221212, name = "R. Cascavel" },
    -- { hash = -1885531417, name = "R. Guiné" },
    -- { hash = -2047509766, name = "R. Solidês" },
    -- { hash = -119993883, name = "R. Paulo Adorno" },
    -- { hash = -1701478065, name = "R. Mestre" },
    -- { hash = -1887703992, name = "R. Chacorore" },
    -- { hash = -1979668734, name = "R. João Cariani" },
    -- { hash = -317475652, name = "Av. Cruzeiro do Sul" },
    -- { hash = 639402203, name = "Av. 9 de Julho" },
    -- { hash = -163478756, name = "Travessa Valongo" },
    -- { hash = -2144193191, name = "R. Renato Pereira" },
    -- { hash = -1766582125, name = "R. Natalina Roque Estefani" },
    -- { hash = 515762876, name = "R. Olavo Leite" },
    -- { hash = 251791713, name = "Praça Bauxita" },
    -- { hash = 1589412475, name = "R. Iná" },
    -- { hash = -2066672211, name = "R. Sitiantes" },
    -- { hash = 367290109, name = "R. Pirai do Norte" },
    -- { hash = 1502743981, name = "Av. Deltinha" },
    -- { hash = -1112034057, name = "R. Madalena" },
    -- { hash = 1582247655, name = "R. Jacó Bertillon" },
    -- { hash = -1755702444, name = "Estrada Serraria" },
    -- { hash = -303336476, name = "R. Nara Leão" },
    -- { hash = -741499794, name = "R. Carla" },
    -- { hash = -206389612, name = "R. Zezo" },
    -- { hash = 127435642, name = "Av Dr.Lincoln" },
    -- { hash = -1560884687, name = "Av. Baltazar Base" },
    -- { hash = -231756, name = "R. Nova Friburgo" },
    -- { hash = -1219752634, name = "Av. Pedro Basso" },
    -- { hash = -1722011478, name = "R. André Luiz" },
    -- { hash = -1577573726, name = "R. Janauira" },
    -- { hash = -862415902, name = "R. Caju" },
    -- { hash = 1266362164, name = "R. Cuevas" },
    -- { hash = -641602866, name = "R. Base Emília" },
    -- { hash = 421113525, name = "Viela Itanhaem" },
    -- { hash = -865957884, name = "R. Signa" },
    -- { hash = -1740997275, name = "Av. Colth" },
    -- { hash = 224335078, name = "Av. Fabio A" },
    -- { hash = 1871869508, name = "Av Clarinha" },
    -- { hash = 1711303319, name = "R. Palestra" },
    -- { hash = 302348953, name = "Est. Galaxy" },
    -- { hash = -852132338, name = "R. Guarulhos" },
    -- { hash = 647252758, name = "R. Nevada" },
    -- { hash = -305940236, name = "R. Efigênia" },
    -- { hash = 745714793, name = "R. Divina" },
    -- { hash = -820353525, name = "R. Base" },
    -- { hash = 99613082, name = "Av. Vovôzinho" },
    -- { hash = 84037695, name = "R. Sete" },
    -- { hash = -2068448071, name = "Av. Justos" },
    -- { hash = 2122598109, name = "R. Oscar Rossin" },
    -- { hash = 161498934, name = "R. Capanema" },
    -- { hash = 1137588479, name = "R. Cecí­lia" },
    -- { hash = 1376516937, name = "Av. Teixeira" },
    -- { hash = -1932531079, name = "R. Novo Piaui" },
    -- { hash = 2139409448, name = "R. José Diogo" },
    -- { hash = 2130549502, name = "R. Q2" },
    -- { hash = 858401381, name = "R. Contenda" },
    -- { hash = -1758117764, name = "R. Oitenta" },
    -- { hash = -718672493, name = "R. Arapoema" },
    -- { hash = 1284661444, name = "R. Andaluzia" },
    -- { hash = 1714798914, name = "R. Particular C" },
    -- { hash = 30934387, name = "Av. Deltinha" },
    -- { hash = 1189907702, name = "R. Tom Jobim" },
    -- { hash = 607427175, name = "R. Urucuí" },
    -- { hash = 1397588007, name = "Viela Manga" },
    -- { hash = 1094585465, name = "R. Sabiá" },
    -- { hash = 119898327, name = "Viela dos Reis" },
    -- { hash = -221825258, name = "Av Carol DuCaos" },
    -- { hash = -418956154, name = "Av. Wemilly A" },
    -- { hash = 629262578, name = "Av. BoostGamer" },
    -- { hash = 409613010, name = "Av. Nova Cantareira" },
    -- { hash = 791067607, name = "R. Quimerat" },
    -- { hash = -1132306461, name = "Viela Tanua" },
    -- { hash = -1912735485, name = "Viela Tupancirata" },
    -- { hash = -1868868207, name = "R. Cascata" },
    -- { hash = -1054680993, name = "R. Schoroeder" },
    -- { hash = 568161725, name = "Boulevard Del Perro" },
    -- { hash = 1834938348, name = "Av. Mafilzinho" },
    -- { hash = -1810087183, name = "R. Henrique" },
    -- { hash = -1853893973, name = "Av. Lima" },
    -- { hash = 2104870696, name = "Viela Luzia" },
    -- { hash = 1945677281, name = "Viela Tala" },
    -- { hash = 1091193293, name = "R. Padilhaum" },
    -- { hash = 1308375563, name = "Praça União" },
    -- { hash = -172004387, name = "R. Agrolândia" },
    -- { hash = -1472109986, name = "R. Marcelino Ramos" },
    -- { hash = 1317352724, name = "R. Jose do Piaui" },
    -- { hash = 1169279549, name = "Av. Cidade Jardim" },
    -- { hash = -1766672289, name = "R. Romênia" },
    -- { hash = -701377429, name = "R. General Osório" },
    -- { hash = 981619837, name = "R. Antônio de Abreu" },
    -- { hash = -457429001, name = "R. Irmã Dirce" },
    -- { hash = 2087879361, name = "R. Rondinha" },
    -- { hash = 776581733, name = "R. Piracicaba" },
    -- { hash = 702395188, name = "R. Gothard" },
    -- { hash = 1999049754, name = "R. Guairaca" },
    -- { hash = 1970420268, name = "R. dos Imigrantes" },
    -- { hash = -1932337127, name = "Av. Celso Garcia" },
    -- { hash = -1126737110, name = "R. Pará" },
    -- { hash = -858728061, name = "R. Ribeirão Preto" },
    -- { hash = 1978002066, name = "R. Lions" },
    -- { hash = -1199592864, name = "Av. Leitão" },
    -- { hash = -1988380363, name = "R. Jurupis" },
    -- { hash = -1270051212, name = "R. Oratório" },
    -- { hash = 2142106034, name = "R. Oratório 2" },
    -- { hash = -1742121949, name = "R. Pedra Furada" },
    -- { hash = 702752937, name = "R. Maripa" },
    -- { hash = 514233399, name = "R. Barra da Estiva" },
    -- { hash = 1264277927, name = "Av. Montanha" },
    -- { hash = -642307807, name = "R. Itaperai" },
    -- { hash = 1989782134, name = "R. Mairinque" },
    -- { hash = 320731036, name = "R. Aragoiania" },
    -- { hash = -932639616, name = "Est. Nobre" },
    -- { hash = -1649175264, name = "Av. Jabaquara" },
    -- { hash = 1680892246, name = "Viela Cinco" },
    -- { hash = 1713022841, name = "R. Buria" },
    -- { hash = 1458733832, name = "Av. Summerz" },
    -- { hash = 146394227, name = "Av Dr. Norris" },
    -- { hash = 1543716113, name = "R. Venus" },
    -- { hash = 1759459593, name = "Av. Stanleys" },
    -- { hash = 13393056, name = "R. Curupis" },
    -- { hash = -519290434, name = "R. Uraí" },
    -- { hash = -380998180, name = "R. Gari" },
    -- { hash = -428570144, name = "Cracolandia" },
    -- { hash = -111553938, name = "Av. Deadshot" },
    -- { hash = -1096634323, name = "Av. Matteo Bei" },
    -- { hash = 1596400942, name = "Av. Tiradentes" },
    -- { hash = -2134115377, name = "R. Venezuela" },
    -- { hash = 530762033, name = "Av. Deads" },
    -- { hash = 11678836, name = "R. da Invernada" },
    -- { hash = 1825093742, name = "R. Tamoios" },
    -- { hash = -675026785, name = "R. Gardens" },
    -- { hash = 128684945, name = "R. Nikola" },
    -- { hash = -1003373330, name = "R. Macário" },
    -- { hash = 572099687, name = "R. Assis Brasil" },
    -- { hash = 270274760, name = "R. Corbélia" },
    -- { hash = -828555118, name = "R. da Fazenda" },
    -- { hash = 1031438454, name = "R. Maria Minelli" },
    -- { hash = 1087402780, name = "Av GRD Carvalho." },
    -- { hash = 1547599225, name = "Av. Nikit0" },
    -- { hash = -987282051, name = "Av. L. Hunsche" },
    -- { hash = -430448832, name = "Av. Senador Teotônio" },
    -- { hash = 1670383606, name = "R. Sudão" },
    -- { hash = 1616724332, name = "Av. Valencio" },
    -- { hash = 1129103708, name = "R. Inácio Lustosa" },
    -- { hash = -1922048877, name = "R. José Peon" },
    -- { hash = 878869087, name = "R. Antonina" },
    -- { hash = 537927529, name = "Av. Tadalafellas" },
    -- { hash = 1332344845, name = "R. da Ordem" },
    -- { hash = -1860704595, name = "R. Pedro de Toledo" },
    -- { hash = -573842316, name = "R. Luiz Rebellatto" },
    -- { hash = -267870621, name = "Av Dr.Picanha" },
    -- { hash = 1078365443, name = "Av. Frutos" },
    -- { hash = -627192581, name = "R. João Havro" },
    -- { hash = 362483193, name = "R. João Eudes" },
    -- { hash = -685741883, name = "R. Melchíades Fangueiro" },
    -- { hash = -865168890, name = "R. Andira" },
    -- { hash = 1580292663, name = "R. do Morro" },
    -- { hash = 1884297396, name = "R. Jalaliel" },
    -- { hash = 676125051, name = "R. Fósforo" },
    -- { hash = 1706885027, name = "Av. Santo Amaro" },
    -- { hash = -74401978, name = "R. do Campo" },
    -- { hash = -1262794829, name = "R. El Shadai" },
    -- { hash = -135656969, name = "R. Galeria" },
    -- { hash = -710539272, name = "Gentry Lane" },
    -- { hash = -1282586415, name = "Beco Juarez Jardim" },
    -- { hash = 158578870, name = "Praça Ernesto Tassini" },
    -- { hash = 1071112323, name = "R. Oficina" },
    -- { hash = -13271429, name = "R. Tiu Berg" },
    -- { hash = -619934426, name = "R. Tibiriçá" },
    -- { hash = -1517798434, name = "R. Juiz Costa Val" },
    -- { hash = -325498996, name = "R. Antônio Gentil" },
    -- { hash = -563748952, name = "Av. Base Marina" },
    -- { hash = -839610466, name = "R. Aeronautas" },
    -- { hash = -1264085241, name = "R. Balsa" },
    -- { hash = 2077573985, name = "R. do Curumim" },
    -- { hash = 214477542, name = "R. Nilo Peçanha" },
    -- { hash = 2106785626, name = "R. Filemon Matos" },
    -- { hash = -893453912, name = "R. Belas Artes" },
    -- { hash = -793701821, name = "R. Costa Pinto" },
    -- { hash = -522934837, name = "R. Florisbela" },
    -- { hash = -1697890968, name = "Praça Rincão" },
    -- { hash = 1548238365, name = "Av. Rebouças" },
}

if cityName == "Base" then
    Streets[#Streets+1] = { hash = 0, name = "" }
    Streets[#Streets+1] = { hash = -1650229529, name = "Av. Roberto Carlos" }
    Streets[#Streets+1] = { hash = 1679357694, name = "Av L. Hunsche" }
    Streets[#Streets+1] = { hash = -1804608311, name = "R. Quatro" }
    Streets[#Streets+1] = { hash = -1791978259, name = "R. Clodomiro Pinheiro" }
    Streets[#Streets+1] = { hash = -1830698864, name = "R. Ouro Verde" }
    Streets[#Streets+1] = { hash = -1872020078, name = "R. Arvore da Cera" }
    Streets[#Streets+1] = { hash = 567258876, name = "R. Acioli Monteiro" }
    Streets[#Streets+1] = { hash = -744494798, name = "R. Antônio Mariani" }
    Streets[#Streets+1] = { hash = 2126748386, name = "R. Tiburno" }
    Streets[#Streets+1] = { hash = 916897355, name = "R. Venceslau" }
    Streets[#Streets+1] = { hash = 853093701, name = "R. Rubens" }
    Streets[#Streets+1] = { hash = 1676954661, name = "R. Cravo do Campo" }
    Streets[#Streets+1] = { hash = -566765044, name = "R. Itacaranha" }
    Streets[#Streets+1] = { hash = 358596139, name = "R. Hercí­lio Luz" }
    Streets[#Streets+1] = { hash = 1497974009, name = "R. Xororó" }
    Streets[#Streets+1] = { hash = 173801282, name = "R. Monteiro Lobato" }
    Streets[#Streets+1] = { hash = -1217521905, name = "R. Banana-Branca" }
    Streets[#Streets+1] = { hash = -182884461, name = "R. Nova Olinda" }
    Streets[#Streets+1] = { hash = 1401592080, name = "R. Paolo Porpora" }
    Streets[#Streets+1] = { hash = 609524159, name = "R. Angélicas" }
    Streets[#Streets+1] = { hash = -364774424, name = "R. Belfort Roxo" }
    Streets[#Streets+1] = { hash = -1694381789, name = "Est. Base" } 
    Streets[#Streets+1] = { hash = 127506487, name = "Vovô Lá Máfia" }
    Streets[#Streets+1] = { hash = -1398838962, name = "Est. Base" }
    Streets[#Streets+1] = { hash = 4155137, name = "Av. Skorpion" }
    Streets[#Streets+1] = { hash = -168827017, name = "R. Durval de Almeida" }
    Streets[#Streets+1] = { hash = -583776065, name = "R. Hemisfério" }
    Streets[#Streets+1] = { hash = 1670951541, name = "R. Cesare Badiali" }
    Streets[#Streets+1] = { hash = -2047518581, name = "R. Charles Naufal" }
    Streets[#Streets+1] = { hash = 1245123266, name = "R. Firmino" }
    Streets[#Streets+1] = { hash = -720113662, name = "R. Crispo" }
    Streets[#Streets+1] = { hash = 422479126, name = "Est. Grande" }
    Streets[#Streets+1] = { hash = -169974511, name = "R. Luís Morales" }
    Streets[#Streets+1] = { hash = -945210448, name = "Praça Ocupação" }
    Streets[#Streets+1] = { hash = -1502208605, name = "R. da Independência" }
    Streets[#Streets+1] = { hash = 1224796925, name = "Av. Tribo" }
    Streets[#Streets+1] = { hash = -1728734423, name = "R. Carlos Reis" }
    Streets[#Streets+1] = { hash = 1305375448, name = "Av. Paulista" } 
    Streets[#Streets+1] = { hash = -994079839, name = "R. Anael" }
    Streets[#Streets+1] = { hash = 825407909, name = "R. Ribeirão Pires" }
    Streets[#Streets+1] = { hash = -409785781, name = "R. Roberto Firmino" }
    Streets[#Streets+1] = { hash = 648011493, name = "R. Caçador Narciso" }
    Streets[#Streets+1] = { hash = 1520509920, name = "R. Manilha" }
    Streets[#Streets+1] = { hash = 954221212, name = "R. Cascavel" }
    Streets[#Streets+1] = { hash = -1885531417, name = "R. Guiné" }
    Streets[#Streets+1] = { hash = -2047509766, name = "R. Solidês" }
    Streets[#Streets+1] = { hash = -119993883, name = "R. Paulo Adorno" }
    Streets[#Streets+1] = { hash = -1701478065, name = "R. Mestre" }
    Streets[#Streets+1] = { hash = -1887703992, name = "R. Chacorore" }
    Streets[#Streets+1] = { hash = -1979668734, name = "R. João Cariani" }
    Streets[#Streets+1] = { hash = -317475652, name = "Av. Cruzeiro do Sul" }
    Streets[#Streets+1] = { hash = 639402203, name = "Av. 9 de Julho" }
    Streets[#Streets+1] = { hash = -163478756, name = "Travessa Valongo" }
    Streets[#Streets+1] = { hash = -2144193191, name = "R. Renato Pereira" }
    Streets[#Streets+1] = { hash = -1766582125, name = "R. Natalina Roque Estefani" }
    Streets[#Streets+1] = { hash = 515762876, name = "R. Olavo Leite" }
    Streets[#Streets+1] = { hash = 251791713, name = "Praça Bauxita" }
    Streets[#Streets+1] = { hash = 1589412475, name = "R. Iná" }
    Streets[#Streets+1] = { hash = -2066672211, name = "R. Sitiantes" }
    Streets[#Streets+1] = { hash = 367290109, name = "R. Pirai do Norte" }
    Streets[#Streets+1] = { hash = 1502743981, name = "Av. Deltinha" }
    Streets[#Streets+1] = { hash = -1112034057, name = "R. Madalena" }
    Streets[#Streets+1] = { hash = 1582247655, name = "R. Jacó Bertillon" }
    Streets[#Streets+1] = { hash = -1755702444, name = "Estrada Serraria" }
    Streets[#Streets+1] = { hash = -303336476, name = "R. Nara Leão" }
    Streets[#Streets+1] = { hash = -741499794, name = "R. Carla" }
    Streets[#Streets+1] = { hash = -206389612, name = "R. Zezo" }
    Streets[#Streets+1] = { hash = 127435642, name = "Av Dr.Lincoln" }
    Streets[#Streets+1] = { hash = -1560884687, name = "Av. Baltazar Base" }
    Streets[#Streets+1] = { hash = -231756, name = "R. Nova Friburgo" }
    Streets[#Streets+1] = { hash = -1219752634, name = "Av. Pedro Basso" }
    Streets[#Streets+1] = { hash = -1722011478, name = "R. André Luiz" }
    Streets[#Streets+1] = { hash = -1577573726, name = "R. Janauira" }
    Streets[#Streets+1] = { hash = -862415902, name = "R. Caju" }
    Streets[#Streets+1] = { hash = 1266362164, name = "R. Cuevas" }
    Streets[#Streets+1] = { hash = -641602866, name = "R. Base Emília" }
    Streets[#Streets+1] = { hash = 421113525, name = "Viela Itanhaem" }
    Streets[#Streets+1] = { hash = -865957884, name = "R. Signa" }
    Streets[#Streets+1] = { hash = -1740997275, name = "Av. Colth" }
    Streets[#Streets+1] = { hash = 224335078, name = "Av. Fabio A" }
    Streets[#Streets+1] = { hash = 1871869508, name = "Av Clarinha" }
    Streets[#Streets+1] = { hash = 1711303319, name = "R. Palestra" }
    Streets[#Streets+1] = { hash = 302348953, name = "Est. Galaxy" }
    Streets[#Streets+1] = { hash = -852132338, name = "R. Guarulhos" }
    Streets[#Streets+1] = { hash = 647252758, name = "R. Nevada" }
    Streets[#Streets+1] = { hash = -305940236, name = "R. Efigênia" }
    Streets[#Streets+1] = { hash = 745714793, name = "R. Divina" }
    Streets[#Streets+1] = { hash = -820353525, name = "R. Base" }
    Streets[#Streets+1] = { hash = 99613082, name = "Av. Vovôzinho" }
    Streets[#Streets+1] = { hash = 84037695, name = "R. Sete" }
    Streets[#Streets+1] = { hash = -2068448071, name = "Av. Justos" }
    Streets[#Streets+1] = { hash = 2122598109, name = "R. Oscar Rossin" }
    Streets[#Streets+1] = { hash = 161498934, name = "R. Capanema" }
    Streets[#Streets+1] = { hash = 1137588479, name = "R. Cecí­lia" }
    Streets[#Streets+1] = { hash = 1376516937, name = "Av. Teixeira" }
    Streets[#Streets+1] = { hash = -1932531079, name = "R. Novo Piaui" }
    Streets[#Streets+1] = { hash = 2139409448, name = "R. José Diogo" }
    Streets[#Streets+1] = { hash = 2130549502, name = "R. Q2" }
    Streets[#Streets+1] = { hash = 858401381, name = "R. Contenda" }
    Streets[#Streets+1] = { hash = -1758117764, name = "R. Oitenta" }
    Streets[#Streets+1] = { hash = -718672493, name = "R. Arapoema" }
    Streets[#Streets+1] = { hash = 1284661444, name = "R. Andaluzia" }
    Streets[#Streets+1] = { hash = 1714798914, name = "R. Particular C" }
    Streets[#Streets+1] = { hash = 30934387, name = "Av. Deltinha" }
    Streets[#Streets+1] = { hash = 1189907702, name = "R. Tom Jobim" }
    Streets[#Streets+1] = { hash = 607427175, name = "R. Urucuí" }
    Streets[#Streets+1] = { hash = 1397588007, name = "Viela Manga" }
    Streets[#Streets+1] = { hash = 1094585465, name = "R. Sabiá" }
    Streets[#Streets+1] = { hash = 119898327, name = "Viela dos Reis" }
    Streets[#Streets+1] = { hash = -221825258, name = "Av Carol DuCaos" }
    Streets[#Streets+1] = { hash = -418956154, name = "Av. Wemilly A" }
    Streets[#Streets+1] = { hash = 629262578, name = "Av. BoostGamer" }
    Streets[#Streets+1] = { hash = 409613010, name = "Av. Nova Cantareira" }
    Streets[#Streets+1] = { hash = 791067607, name = "R. Quimerat" }
    Streets[#Streets+1] = { hash = -1132306461, name = "Viela Tanua" }
    Streets[#Streets+1] = { hash = -1912735485, name = "Viela Tupancirata" }
    Streets[#Streets+1] = { hash = -1868868207, name = "R. Cascata" }
    Streets[#Streets+1] = { hash = -1054680993, name = "R. Schoroeder" }
    Streets[#Streets+1] = { hash = 568161725, name = "Boulevard Del Perro" }
    Streets[#Streets+1] = { hash = 1834938348, name = "Av. Mafilzinho" }
    Streets[#Streets+1] = { hash = -1810087183, name = "R. Henrique" }
    Streets[#Streets+1] = { hash = -1853893973, name = "Av. Lima" }
    Streets[#Streets+1] = { hash = 2104870696, name = "Viela Luzia" }
    Streets[#Streets+1] = { hash = 1945677281, name = "Viela Tala" }
    Streets[#Streets+1] = { hash = 1091193293, name = "R. Padilhaum" }
    Streets[#Streets+1] = { hash = 1308375563, name = "Praça União" }
    Streets[#Streets+1] = { hash = -172004387, name = "R. Agrolândia" }
    Streets[#Streets+1] = { hash = -1472109986, name = "R. Marcelino Ramos" }
    Streets[#Streets+1] = { hash = 1317352724, name = "R. Jose do Piaui" }
    Streets[#Streets+1] = { hash = 1169279549, name = "Av. Cidade Jardim" }
    Streets[#Streets+1] = { hash = -1766672289, name = "R. Romênia" }
    Streets[#Streets+1] = { hash = -701377429, name = "R. General Osório" }
    Streets[#Streets+1] = { hash = 981619837, name = "R. Antônio de Abreu" }
    Streets[#Streets+1] = { hash = -457429001, name = "R. Irmã Dirce" }
    Streets[#Streets+1] = { hash = 2087879361, name = "R. Rondinha" }
    Streets[#Streets+1] = { hash = 776581733, name = "R. Piracicaba" }
    Streets[#Streets+1] = { hash = 702395188, name = "R. Gothard" }
    Streets[#Streets+1] = { hash = 1999049754, name = "R. Guairaca" }
    Streets[#Streets+1] = { hash = 1970420268, name = "R. dos Imigrantes" }
    Streets[#Streets+1] = { hash = -1932337127, name = "Av. Celso Garcia" }
    Streets[#Streets+1] = { hash = -1126737110, name = "R. Pará" }
    Streets[#Streets+1] = { hash = -858728061, name = "R. Ribeirão Preto" }
    Streets[#Streets+1] = { hash = 1978002066, name = "R. Lions" }
    Streets[#Streets+1] = { hash = -1199592864, name = "Av. Leitão" }
    Streets[#Streets+1] = { hash = -1988380363, name = "R. Jurupis" }
    Streets[#Streets+1] = { hash = -1270051212, name = "R. Oratório" }
    Streets[#Streets+1] = { hash = 2142106034, name = "R. Oratório 2" }
    Streets[#Streets+1] = { hash = -1742121949, name = "R. Pedra Furada" }
    Streets[#Streets+1] = { hash = 702752937, name = "R. Maripa" }
    Streets[#Streets+1] = { hash = 514233399, name = "R. Barra da Estiva" }
    Streets[#Streets+1] = { hash = 1264277927, name = "Av. Montanha" }
    Streets[#Streets+1] = { hash = -642307807, name = "R. Itaperai" }
    Streets[#Streets+1] = { hash = 1989782134, name = "R. Mairinque" }
    Streets[#Streets+1] = { hash = 320731036, name = "R. Aragoiania" }
    Streets[#Streets+1] = { hash = -932639616, name = "Est. Nobre" }
    Streets[#Streets+1] = { hash = -1649175264, name = "Av. Jabaquara" }
    Streets[#Streets+1] = { hash = 1680892246, name = "Viela Cinco" }
    Streets[#Streets+1] = { hash = 1713022841, name = "R. Buria" }
    Streets[#Streets+1] = { hash = 1458733832, name = "Av. Summerz" }
    Streets[#Streets+1] = { hash = 146394227, name = "Av Dr. Norris" }
    Streets[#Streets+1] = { hash = 1543716113, name = "R. Venus" }
    Streets[#Streets+1] = { hash = 1759459593, name = "Av. Stanleys" }
    Streets[#Streets+1] = { hash = 13393056, name = "R. Curupis" }
    Streets[#Streets+1] = { hash = -519290434, name = "R. Uraí" }
    Streets[#Streets+1] = { hash = -380998180, name = "R. Gari" }
    Streets[#Streets+1] = { hash = -428570144, name = "Cracolandia" }
    Streets[#Streets+1] = { hash = -111553938, name = "Av. Deadshot" }
    Streets[#Streets+1] = { hash = -1096634323, name = "Av. Matteo Bei" }
    Streets[#Streets+1] = { hash = 1596400942, name = "Av. Tiradentes" }
    Streets[#Streets+1] = { hash = -2134115377, name = "R. Venezuela" }
    Streets[#Streets+1] = { hash = 530762033, name = "Av. Deads" }
    Streets[#Streets+1] = { hash = 11678836, name = "R. da Invernada" }
    Streets[#Streets+1] = { hash = 1825093742, name = "R. Tamoios" }
    Streets[#Streets+1] = { hash = -675026785, name = "R. Gardens" }
    Streets[#Streets+1] = { hash = 128684945, name = "R. Nikola" }
    Streets[#Streets+1] = { hash = -1003373330, name = "R. Macário" }
    Streets[#Streets+1] = { hash = 572099687, name = "R. Assis Brasil" }
    Streets[#Streets+1] = { hash = 270274760, name = "R. Corbélia" }
    Streets[#Streets+1] = { hash = -828555118, name = "R. da Fazenda" }
    Streets[#Streets+1] = { hash = 1031438454, name = "R. Maria Minelli" }
    Streets[#Streets+1] = { hash = 1087402780, name = "Av GRD Carvalho." }
    Streets[#Streets+1] = { hash = 1547599225, name = "Av. Nikit0" }
    Streets[#Streets+1] = { hash = -987282051, name = "Av. L. Hunsche" }
    Streets[#Streets+1] = { hash = -430448832, name = "Av. Senador Teotônio" }
    Streets[#Streets+1] = { hash = 1670383606, name = "R. Sudão" }
    Streets[#Streets+1] = { hash = 1616724332, name = "Av. Valencio" }
    Streets[#Streets+1] = { hash = 1129103708, name = "R. Inácio Lustosa" }
    Streets[#Streets+1] = { hash = -1922048877, name = "R. José Peon" }
    Streets[#Streets+1] = { hash = 878869087, name = "R. Antonina" }
    Streets[#Streets+1] = { hash = 537927529, name = "Av. Tadalafellas" }
    Streets[#Streets+1] = { hash = 1332344845, name = "R. da Ordem" }
    Streets[#Streets+1] = { hash = -1860704595, name = "R. Pedro de Toledo" }
    Streets[#Streets+1] = { hash = -573842316, name = "R. Luiz Rebellatto" }
    Streets[#Streets+1] = { hash = -267870621, name = "Av Dr.Picanha" }
    Streets[#Streets+1] = { hash = 1078365443, name = "Av. Frutos" }
    Streets[#Streets+1] = { hash = -627192581, name = "R. João Havro" }
    Streets[#Streets+1] = { hash = 362483193, name = "R. João Eudes" }
    Streets[#Streets+1] = { hash = -685741883, name = "R. Melchíades Fangueiro" }
    Streets[#Streets+1] = { hash = -865168890, name = "R. Andira" }
    Streets[#Streets+1] = { hash = 1580292663, name = "R. do Morro" }
    Streets[#Streets+1] = { hash = 1884297396, name = "R. Jalaliel" }
    Streets[#Streets+1] = { hash = 676125051, name = "R. Fósforo" }
    Streets[#Streets+1] = { hash = 1706885027, name = "Av. Santo Amaro" }
    Streets[#Streets+1] = { hash = -74401978, name = "R. do Campo" }
    Streets[#Streets+1] = { hash = -1262794829, name = "R. El Shadai" }
    Streets[#Streets+1] = { hash = -135656969, name = "R. Galeria" }
    Streets[#Streets+1] = { hash = -710539272, name = "Gentry Lane" }
    Streets[#Streets+1] = { hash = -1282586415, name = "Beco Juarez Jardim" }
    Streets[#Streets+1] = { hash = 158578870, name = "Praça Ernesto Tassini" }
    Streets[#Streets+1] = { hash = 1071112323, name = "R. Oficina" }
    Streets[#Streets+1] = { hash = -13271429, name = "R. Tiu Berg" }
    Streets[#Streets+1] = { hash = -619934426, name = "R. Tibiriçá" }
    Streets[#Streets+1] = { hash = -1517798434, name = "R. Juiz Costa Val" }
    Streets[#Streets+1] = { hash = -325498996, name = "R. Antônio Gentil" }
    Streets[#Streets+1] = { hash = -563748952, name = "Av. Base Marina" }
    Streets[#Streets+1] = { hash = -839610466, name = "R. Aeronautas" }
    Streets[#Streets+1] = { hash = -1264085241, name = "R. Balsa" }
    Streets[#Streets+1] = { hash = 2077573985, name = "R. do Curumim" }
    Streets[#Streets+1] = { hash = 214477542, name = "R. Nilo Peçanha" }
    Streets[#Streets+1] = { hash = 2106785626, name = "R. Filemon Matos" }
    Streets[#Streets+1] = { hash = -893453912, name = "R. Belas Artes" }
    Streets[#Streets+1] = { hash = -793701821, name = "R. Costa Pinto" }
    Streets[#Streets+1] = { hash = -522934837, name = "R. Florisbela" }
    Streets[#Streets+1] = { hash = -1697890968, name = "Praça Rincão" }
    Streets[#Streets+1] = { hash = 1548238365, name = "Av. Rebouças" }   
end