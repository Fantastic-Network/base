-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("characters/Person","SELECT * FROM characters WHERE id = ?")
vRP.Prepare("characters/rPerson","SELECT * FROM `characters` WHERE `id` = ?")
vRP.Prepare("characters/GetLicense","SELECT * FROM characters WHERE license = @license")
vRP.Prepare("characters/getPhone","SELECT id FROM characters WHERE phone = @phone")
vRP.Prepare("characters/updatePhone","UPDATE characters SET phone = @phone WHERE id = @id")
vRP.Prepare("characters/updateTitle","UPDATE characters SET title = @title WHERE id = @id")
vRP.Prepare("characters/removeCharacter","UPDATE characters SET deleted = 1 WHERE id = @id")
vRP.Prepare("characters/UpdateSkin","UPDATE characters SET skin = @skin WHERE id = @Passport")
vRP.Prepare("characters/giveGarage","UPDATE characters SET garages = garages + @garages WHERE id = @Passport")
vRP.Prepare("characters/addFines","UPDATE characters SET fines = fines + @fines WHERE id = @id")
vRP.Prepare("characters/setPrison","UPDATE characters SET prison = @prison WHERE id = @Passport")
vRP.Prepare("characters/removeFines","UPDATE characters SET fines = fines - @fines WHERE id = @id")
vRP.Prepare("characters/ClearFines","UPDATE characters SET fines = 0 WHERE id = @id")
vRP.Prepare("characters/addBank","UPDATE characters SET bank = bank + @amount WHERE id = @Passport")
vRP.Prepare("characters/remBank","UPDATE characters SET bank = bank - @amount WHERE id = @Passport")
vRP.Prepare("characters/wipeBank","UPDATE characters SET bank = 0 WHERE id = @Passport")
vRP.Prepare("characters/UserLicense","SELECT * FROM characters WHERE id = @id and license = @license")
vRP.Prepare("characters/Characters","SELECT * FROM characters WHERE license = @license and deleted = 0")
vRP.Prepare("characters/removePrison","UPDATE characters SET prison = prison - @prison WHERE id = @Passport")
vRP.Prepare("characters/updateName","UPDATE characters SET name = @name, name2 = @name2 WHERE id = @Passport")
vRP.Prepare("characters/Tracking","UPDATE characters SET tracking = tracking + @tracking WHERE id = @Passport")
vRP.Prepare("characters/avarageFPS","UPDATE characters SET avarageFPS = @avarageFPS WHERE id = @Passport")
vRP.Prepare("characters/UpgradeSpending","UPDATE characters SET spending = spending + @spending WHERE id = @Passport")
vRP.Prepare("characters/DowngradeSpending","UPDATE characters SET spending = spending - @spending WHERE id = @Passport")
vRP.Prepare("characters/lastCharacters","SELECT MAX(id) FROM characters WHERE license = @license ORDER LIMIT 1")
vRP.Prepare("characters/UpgradeCardlimit","UPDATE characters SET cardlimit = cardlimit + @cardlimit WHERE id = @Passport")
vRP.Prepare("characters/DowngradeCardlimit","UPDATE characters SET cardlimit = cardlimit - @cardlimit WHERE id = @Passport")
vRP.Prepare("characters/countPersons","SELECT COUNT(license) as qtd FROM characters WHERE license = @license and deleted = 0")
vRP.Prepare("characters/newCharacter","INSERT INTO characters(license,name,name2,sex,skin,phone,blood,age) VALUES(@license,@name,@name2,@sex,@skin,@phone,@blood,@age)")
vRP.Prepare("characters/updateLogin","UPDATE characters SET login = current_timestamp() WHERE id = @Passport")
vRP.Prepare("characters/updateToxic","UPDATE characters SET toxic = @Toxic WHERE id = @Passport")
vRP.Prepare("characters/BankZero","UPDATE characters SET bank = 0 WHERE bank < 0")
vRP.Prepare("characters/UpdateRelationship","UPDATE characters SET relationship = @relationship WHERE id = @Passport")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCOUNTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("accounts/Account","SELECT * FROM `accounts` WHERE `license` = ?")
vRP.Prepare("accounts/rAccount","SELECT * FROM `accounts` WHERE `license` = ?")
vRP.Prepare("accounts/GetToken","SELECT id FROM accounts WHERE token = @token")
vRP.Prepare("accounts/GenerateToken","UPDATE accounts SET token = @token WHERE license = @license")
vRP.Prepare("accounts/AccountId","SELECT * FROM accounts WHERE id = @id")
vRP.Prepare("accounts/GetAccount","SELECT id FROM accounts WHERE discord = @discord")
vRP.Prepare("accounts/GetDiscord","SELECT discord FROM accounts WHERE id = @accountId")
vRP.Prepare("accounts/newAccount","INSERT INTO accounts(license) VALUES(@license)")
vRP.Prepare("accounts/AddGems","UPDATE accounts SET gems = gems + @gems WHERE license = @license")
vRP.Prepare("accounts/setIPInfo","UPDATE accounts SET ip = @ip WHERE id = @accountId")
vRP.Prepare("accounts/setlastIp","UPDATE accounts SET last_ip = @last_ip WHERE id = @accountId")
vRP.Prepare("accounts/Rolepass","UPDATE accounts SET rolepass = @rolepass WHERE license = @license")
vRP.Prepare("accounts/setPremium","UPDATE accounts SET premium = @premium WHERE license = @license")
vRP.Prepare("accounts/RemoveGems","UPDATE accounts SET gems = gems - @gems WHERE license = @license")
vRP.Prepare("accounts/infosUpdatechars","UPDATE accounts SET chars = chars + 1 WHERE license = @license")
vRP.Prepare("accounts/updatePremium","UPDATE accounts SET premium = premium + 2592000 WHERE license = @license")
vRP.Prepare("accounts/updateWhitelist","UPDATE accounts SET whitelist = 1 WHERE id = @id")
vRP.Prepare("accounts/removeWhitelist","UPDATE accounts SET whitelist = 0 WHERE id = @id")
vRP.Prepare("accounts/updateAmountLogins","UPDATE accounts SET amount_logins = amount_logins + 1 WHERE license = @license")
vRP.Prepare("accounts/GetLogins","SELECT amount_logins FROM accounts WHERE id = @accountId")
vRP.Prepare("accounts/updateAmountPurchased","UPDATE accounts SET purchased = purchased + @amount WHERE id = @id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANNED_IP
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("banned_ip/CheckIP","SELECT id FROM banned_ip WHERE ip = @ip")
vRP.Prepare("banned_ip/CheckRIP","SELECT `id` FROM `banned_ip` WHERE ip = ?")
vRP.Prepare("banned_discord/CheckDiscord","SELECT id FROM accounts WHERE discord = @discord AND discord IS NOT NULL AND discord <> '0'")
vRP.Prepare("banneds_hwid/CheckRDiscord","SELECT `id` FROM `accounts` WHERE `discord` = ?")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("playerdata/GetData","SELECT * FROM playerdata WHERE Passport = @Passport AND dkey = @dkey")
vRP.Prepare("playerdata/rGetData","SELECT * FROM `playerdata` WHERE `Passport` = ? AND `dkey` = ?")
vRP.Prepare("playerdata/SetData","REPLACE INTO playerdata(Passport,dkey,dvalue) VALUES(@Passport,@dkey,@dvalue)")
vRP.Prepare("playerdata/SetData","REPLACE INTO playerdata(Passport,dkey,dvalue) VALUES(@Passport,@dkey,@dvalue)")
vRP.Prepare("playerdata/UpdateData","UPDATE playerdata SET dvalue = ? WHERE Passport = ? AND dkey = ?")
vRP.Prepare("playerdata/InsertUpdate","INSERT INTO playerdata(Passport,dkey,dvalue) VALUES(@Passport,@dkey,@dvalue) ON DUPLICATE KEY UPDATE dvalue = @dvalue")
vRP.Prepare("playerdata/InsertData","INSERT INTO playerdata(Passport,dkey,dvalue) VALUES(?,?,?)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITYDATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("entitydata/GetData","SELECT * FROM entitydata WHERE dkey = @dkey")
vRP.Prepare("entitydata/RemoveData","DELETE FROM entitydata WHERE dkey = @dkey")
vRP.Prepare("entitydata/SetData","REPLACE INTO entitydata(dkey,dvalue) VALUES(@dkey,@dvalue)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("vehicles/plateVehicles","SELECT * FROM vehicles WHERE plate = @plate")
vRP.Prepare("vehicles/plateVehiclesId","SELECT id FROM vehicles WHERE plate = @plate")
vRP.Prepare("vehicles/UserVehicles","SELECT vehicle,plate,health,engine,body,fuel,work,UNIX_TIMESTAMP(expires) as expires FROM vehicles WHERE Passport = @Passport")
vRP.Prepare("vehicles/removeVehicles","DELETE FROM vehicles WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/selectVehicles","SELECT * FROM vehicles WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/paymentArrest","UPDATE vehicles SET arrest = 0 WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/moveVehicles","UPDATE vehicles SET Passport = @OtherPassport WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/plateVehiclesUpdate","UPDATE vehicles SET plate = @plate WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/rentalVehiclesDays","UPDATE vehicles SET rental = rental + 2592000 WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/arrestVehicles","UPDATE vehicles SET arrest = UNIX_TIMESTAMP() + 2592000 WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/updateVehiclesTax","UPDATE vehicles SET tax = UNIX_TIMESTAMP() + 2592000 WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/rentalVehiclesUpdate","UPDATE vehicles SET rental = UNIX_TIMESTAMP() + 2592000 WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/addVehicles","INSERT IGNORE INTO vehicles(Passport,vehicle,plate,work,tax,degrade) VALUES(@Passport,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 604800,UNIX_TIMESTAMP())")
vRP.Prepare("vehicles/rentalVehicles","INSERT IGNORE INTO vehicles(Passport,vehicle,plate,work,rental,tax,degrade) VALUES(@Passport,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 2592000,UNIX_TIMESTAMP() + 604800,UNIX_TIMESTAMP())")
vRP.Prepare("vehicles/rentalVehiclesTime","INSERT IGNORE INTO vehicles(Passport,vehicle,plate,work,rental,tax,degrade) VALUES(@Passport,@vehicle,@plate,@work,UNIX_TIMESTAMP() + @rental,UNIX_TIMESTAMP() + 604800,UNIX_TIMESTAMP())")
vRP.Prepare("vehicles/updateVehicles","UPDATE vehicles SET engine = @engine, body = @body, health = @health, fuel = @fuel, doors = @doors, windows = @windows, tyres = @tyres WHERE Passport = @Passport AND vehicle = @vehicle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANNEDS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("banneds/GetBanned","SELECT * FROM banneds WHERE accountId = @accountId")
vRP.Prepare("banneds/GetRBanned","SELECT `id` FROM `banneds` WHERE `accountId` = ?")
vRP.Prepare("banneds/RemoveBanned","DELETE FROM banneds WHERE accountId = @accountId")
vRP.Prepare("banneds/InsertBanned","INSERT IGNORE INTO banneds(accountId,reason) VALUES(@accountId,@reason)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("chests/GetChests","SELECT * FROM chests WHERE name = @name")
vRP.Prepare("chests/UpdateChests","UPDATE chests SET weight = weight + 10 WHERE name = @name")
vRP.Prepare("chests/InsertChest","INSERT IGNORE INTO chests(name,weight,perm,logs) VALUES(@name,@weight,@perm,@logs)")
vRP.Prepare("chests/InsertCustomChest","INSERT IGNORE INTO custom_chests(Name,Owner,Weight,Coords) VALUES(@name,@owner,@weight,@coords)")
vRP.Prepare("chests/GetCustomChests","SELECT * FROM custom_chests")
vRP.Prepare("chests/RemoveCustomChest","DELETE FROM custom_chests where Name = @name")
vRP.Prepare("chests/UpdatePermChests","UPDATE custom_chests SET permission = @permission WHERE name = @name")
vRP.Prepare("chests/UpdateAlarm","UPDATE custom_chests SET Alarm = @Alarm WHERE Name = @Name")
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("races/Result","SELECT * FROM races WHERE Race = @Race AND Passport = @Passport")
vRP.Prepare("races/Ranking","SELECT * FROM races WHERE Race = @Race ORDER BY Points ASC LIMIT 5")
vRP.Prepare("races/TopFive","SELECT * FROM races WHERE Race = @Race ORDER BY Points ASC LIMIT 1 OFFSET 4")
vRP.Prepare("races/Records","UPDATE races SET Points = @Points, Vehicle = @Vehicle WHERE Race = @Race AND Passport = @Passport")
vRP.Prepare("races/Insert","INSERT INTO races(Race,Passport,Name,Vehicle,Points) VALUES(@Race,@Passport,@Name,@Vehicle,@Points)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("warehouse/Result","SELECT * FROM fidentity WHERE id = @id")
vRP.Prepare("fidentity/GetIdentity","SELECT id FROM fidentity ORDER BY id DESC LIMIT 1")
vRP.Prepare("fidentity/NewIdentity","INSERT INTO fidentity(name,name2,blood) VALUES(@name,@name2,@blood)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAREHOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("warehouse/Informations","SELECT * FROM warehouse WHERE name = @name")
vRP.Prepare("warehouse/Upgrade","UPDATE warehouse SET weight = weight + 10 WHERE name = @name")
vRP.Prepare("warehouse/Password","UPDATE warehouse SET password = @password WHERE name = @name")
vRP.Prepare("warehouse/Acess","SELECT * FROM warehouse WHERE name = @name AND password = @password")
vRP.Prepare("warehouse/Tax","UPDATE warehouse SET tax = UNIX_TIMESTAMP() + 2592000 WHERE name = @name")
vRP.Prepare("warehouse/Buy","INSERT INTO warehouse(name,password,Passport,tax) VALUES(@name,@password,@Passport,UNIX_TIMESTAMP() + 2592000)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("fines/List","SELECT * FROM fines WHERE Passport = @Passport")
vRP.Prepare("fines/Remove","DELETE FROM fines WHERE Passport = @Passport AND id = @id")
vRP.Prepare("fines/ClearFines","DELETE FROM fines WHERE Passport = @Passport")
vRP.Prepare("fines/Check","SELECT * FROM fines WHERE Passport = @Passport AND id = @id")
vRP.Prepare("fines/Add","INSERT INTO fines(Passport,Name,Date,Hour,Value,Message,mdt) VALUES(@Passport,@Name,@Date,@Hour,@Value,@Message,@mdt)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("taxs/List","SELECT * FROM taxs WHERE Passport = @Passport")
vRP.Prepare("taxs/Remove","DELETE FROM taxs WHERE Passport = @Passport AND id = @id")
vRP.Prepare("taxs/Check","SELECT * FROM taxs WHERE Passport = @Passport AND id = @id")
vRP.Prepare("taxs/Add","INSERT INTO taxs(Passport,Name,Date,Hour,Value,Message) VALUES(@Passport,@Name,@Date,@Hour,@Value,@Message)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPENDENTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("dependents/List","SELECT * FROM dependents WHERE Passport = @Passport")
vRP.Prepare("dependents/Remove","DELETE FROM dependents WHERE Passport = @Passport AND Dependent = @Dependent")
vRP.Prepare("dependents/Check","SELECT * FROM dependents WHERE Passport = @Passport AND Dependent = @Dependent")
vRP.Prepare("dependents/Add","INSERT INTO dependents(Passport,Dependent,Name) VALUES(@Passport,@Dependent,@Name)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("invoices/Remove","DELETE FROM invoices WHERE id = @id")
vRP.Prepare("invoices/Check","SELECT * FROM invoices WHERE id = @id")
vRP.Prepare("invoices/List","SELECT * FROM invoices WHERE Passport = @Passport")
vRP.Prepare("invoices/Add","INSERT INTO invoices(Passport,Received,Type,Reason,Holder,Value) VALUES(@Passport,@Received,@Type,@Reason,@Holder,@Value)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVESTMENTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("investments/Remove","DELETE FROM investments WHERE Passport = @Passport")
vRP.Prepare("investments/Check","SELECT * FROM investments WHERE Passport = @Passport")
vRP.Prepare("investments/Add","INSERT INTO investments(Passport,Deposit,Last) VALUES(@Passport,@Deposit,UNIX_TIMESTAMP() + 86400)")
vRP.Prepare("investments/Invest","UPDATE investments SET Deposit = Deposit + @Value, Last = UNIX_TIMESTAMP() + 86400 WHERE Passport = @Passport")
vRP.Prepare("investments/Actives","UPDATE investments SET Monthly = Monthly + FLOOR((Deposit + Liquid) * 0.05), Liquid = Liquid + FLOOR((Deposit + Liquid) * 0.005), Last = UNIX_TIMESTAMP() + 86400 WHERE Last < UNIX_TIMESTAMP()")
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEW PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("new_player/getExistAction", "SELECT id FROM new_player WHERE id = @id AND action = @action")
vRP.Prepare("new_player/setNewAction", "INSERT INTO new_player(id,action) VALUES(@id,@action)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER PURCHASES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("player_purchases/setNewPurchase", "INSERT INTO player_purchases(Passport,Price,orderID,Type,Packages) VALUES(@Passport,@Price,@orderID,@Type,@Packages)")
vRP.Prepare("player_purchases/getPurchase","SELECT orderID FROM player_purchases WHERE orderID = @orderID")
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEW PLAYER_PROMO
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("new_player_promo/getExistPromo","SELECT id,token,UNIX_TIMESTAMP(date) as expires,discount FROM new_player_promo WHERE redeemed = 0 AND accountID = @id AND DATE > DATE_SUB(current_timestamp(), INTERVAL 2 DAY)")
vRP.Prepare("new_player_promo/getAllPromo","SELECT * FROM new_player_promo WHERE NOT tokenId=0")
vRP.Prepare("new_player_promo/setNewPromo", "INSERT INTO new_player_promo(accountID,token,tokenId,discount,expires) VALUES(@id,@token,@tokenId,@discount,DATE_ADD(CURRENT_TIMESTAMP(),INTERVAL + @Days DAY))")
vRP.Prepare("new_player_promo/redeemedPromo","UPDATE new_player_promo SET redeemed = 1 WHERE tokenId = @tokenId")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCOUNTS LOGIN
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("accounts_login/setNewLogin", "INSERT INTO accounts_login(id) VALUES(@id)")
vRP.Prepare("accounts_login/setLogoff","UPDATE accounts_login SET logoff = current_timestamp() WHERE id_pk = ?")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCOUNTS LOGIN
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("players_amount/setTime", "INSERT INTO players_amount(amount,date) VALUES(@total,current_timestamp())")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCOUNTS LOGIN
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("groups_amount/setTime", "INSERT INTO players_amount_group(`amount`, `group`) VALUES(@total, @group)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDS SHOP
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("peds_shop/getPeds", "SELECT Passport,info FROM peds_shop") 
vRP.Prepare("peds_shop/addPed", "INSERT INTO peds_shop(Passport,info) VALUES(@id,@info) ON DUPLICATE KEY UPDATE info = @info")

-----------------------------------------------------------------------------------------------------------------------------------------
-- DEALERSHIP
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare('dealership/select_vehicles', 'SELECT * FROM dealership WHERE amount > 0')
vRP.Prepare('dealership/insert_vehicle', 'REPLACE INTO dealership(dealership_index, vehicle, amount) VALUES (@dealershipIndex, @vehicle, @amount)')
vRP.Prepare('dealership/update_vehicle', 'UPDATE dealership SET amount = @amount WHERE vehicle = @vehicle AND dealership_index = @dealershipIndex')
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEMPORARY
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("temporary_banneds/addBanned","INSERT INTO temporary_banneds(id,time,reason,adminid) VALUES(@id,@time,@reason,@Admin) ON DUPLICATE KEY UPDATE time = @time,reason = @reason")
vRP.Prepare("temporary_banneds/getBanned","SELECT id,time,reason,adminid as Admin FROM temporary_banneds WHERE id = @id")
vRP.Prepare("temporary_banneds/updateBanned","UPDATE temporary_banneds SET time = @time WHERE id = @id")
vRP.Prepare("temporary_banneds/deleteBanned","DELETE FROM temporary_banneds WHERE id = @id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("transactions/List","SELECT * FROM transactions WHERE Passport = @Passport ORDER BY id DESC LIMIT @Limit")
vRP.Prepare("transactions/Add","INSERT INTO transactions(Passport,Type,Date,Value,Balance) VALUES(@Passport,@Type,@Date,@Value,@Balance)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAINEL
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("painel/getallGroups", "SELECT * FROM painel")
vRP.Prepare("painel/getallVip", "SELECT level FROM painel WHERE name = @name")
vRP.Prepare("painel/insertOnPainel", "INSERT INTO painel (name) VALUES(@name)")
vRP.Prepare("painel/setDiscord", "UPDATE painel SET discord = @discord WHERE name = @name")
vRP.Prepare("painel/setFacLevel", "UPDATE painel SET level = @level WHERE name = @name")
vRP.Prepare("painel/setAllinGroup", "UPDATE painel SET members = @members, amount = @amount, bankLogs = @bankLogs WHERE name = @name")
vRP.Prepare("accounts/getPriority","SELECT `priority` FROM `accounts` WHERE `license` =  ?")
vRP.Prepare("accounts/setPriority","UPDATE accounts SET priority = ? WHERE license = ?")
vRP.Prepare("accounts/getLastLogin","SELECT UNIX_TIMESTAMP(login) as login FROM characters WHERE id = @Passport")
vRP.Prepare("painel/getAllPlayersInGroup","SELECT painel_members.id,painel_members.points,painel_members.passport,painel_members.recruiter,painel_members.groupid,painel_roles.role,painel_members.recruiter,UNIX_TIMESTAMP(painel_members.recruiter_date) AS recruiter_date FROM painel_members JOIN painel_roles ON painel_roles.id = painel_members.roleid WHERE groupid = @groupId AND fired = 0")
vRP.Prepare("painel/getGroupTransactions","SELECT painel_bank.id,painel_bank.passport,painel_bank.type,painel_bank.quantity,UNIX_TIMESTAMP(painel_bank.timer) as timer FROM painel_bank WHERE groupid = @groupId ORDER BY timer DESC LIMIT 20")
vRP.Prepare("painel/insertBankLog","INSERT INTO painel_bank (groupid,passport,type,quantity) VALUES(@groupId,@passport,@type,@quantity)")
vRP.Prepare("painel/getGroupAllWithdraw","SELECT SUM(quantity) as quantity FROM painel_bank WHERE groupid = @groupId AND type = 1")
vRP.Prepare("painel/getGroupAllDeposit","SELECT SUM(quantity) as quantity FROM painel_bank WHERE groupid = @groupId AND type = 2")
vRP.Prepare("painel/getGroupMonthWithdraw","SELECT SUM(quantity) as quantity FROM painel_bank WHERE groupid = @groupId AND type = 1 AND timer >= DATE_SUB(current_timestamp(), INTERVAL 1 MONTH)")
vRP.Prepare("painel/getGroupMonthDeposit","SELECT SUM(quantity) as quantity FROM painel_bank WHERE groupid = @groupId AND type = 2 AND timer >= DATE_SUB(current_timestamp(), INTERVAL 1 MONTH)")
vRP.Prepare("painel/getGroupMonthDeposit","SELECT SUM(quantity) as quantity FROM painel_bank WHERE groupid = @groupId AND type = 2 AND timer >= DATE_SUB(current_timestamp(), INTERVAL 1 MONTH)")
vRP.Prepare("painel/getGroupTotalMembers","SELECT * FROM painel_members WHERE groupid = @groupid")
vRP.Prepare("painel/getGroupMonthMembers","SELECT * FROM painel_members WHERE groupid = @groupid AND recruiter_date >= DATE_SUB(current_timestamp(), INTERVAL 1 MONTH)")
vRP.Prepare("painel/getGroupLatestRecruited","SELECT id,passport,recruiter,groupid,recruiter,UNIX_TIMESTAMP(recruiter_date) as timer FROM painel_members WHERE groupid = @groupid ORDER BY recruiter_date DESC LIMIT 5")
vRP.Prepare("painel/getMemberTotalRecruited","SELECT COUNT(*) as total FROM painel_members WHERE groupid = @groupid AND recruiter = @passport AND recruiter_date >= DATE_SUB(current_timestamp(), INTERVAL 1 DAY)")
vRP.Prepare("painel/getMemberMonthRecruited","SELECT COUNT(*) as total FROM painel_members WHERE groupid = @groupid AND recruiter = @passport AND recruiter_date >= DATE_SUB(current_timestamp(), INTERVAL 1 WEEK)")
vRP.Prepare("painel/insertMember", "INSERT INTO painel_members(passport,groupid,roleid,recruiter) VALUES(@Passport,@GroupId,@RoleId,@Recruiter)")
vRP.Prepare("painel/updateGroup","UPDATE painel SET bankAmount = @bankAmount, organization_points = @Points WHERE id = @GroupId")
vRP.Prepare("painel/updateMember","UPDATE painel_members SET roleid = @Role, points = @Points WHERE groupid = @GroupId and passport = @Passport")
vRP.Prepare("painel/setMemberFired","UPDATE painel_members SET fired = 1 WHERE groupid = @GroupId and passport = @Passport")
vRP.Prepare("painel/getAwayMembers","SELECT characters.id FROM characters WHERE characters.login > DATE_SUB(NOW(), INTERVAL 15 DAY) AND EXISTS (SELECT id,fired FROM painel_members WHERE painel_members.passport = characters.id AND painel_members.fired = 0)")
vRP.Prepare("painel/addDomination", "UPDATE painel SET domination = domination + 1 WHERE name = @name")
-----------------------------------------------------------------------------------------------------------------------------------------
-- HWID
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("banneds_hwid/setHwid","INSERT IGNORE INTO banneds_hwid(token,accountId) VALUES(?,?)")
vRP.Prepare("banneds_hwid/getHwid","SELECT reason,id,accountId FROM banneds_hwid WHERE token = @Token AND banned = 1")
vRP.Prepare("banneds_hwid/getRHwid","SELECT `reason`,`id`,`accountId` FROM `banneds_hwid` WHERE `token` = @token AND `banned` = 1")
-----------------------------------------------------------------------------------------------------------------------------------------
-- HWID
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("season_pass/getUserPass","SELECT * FROM season_pass WHERE passport = @Passport")
vRP.Prepare("season_pass/updateUserPass","UPDATE season_pass SET done = @Done, experience = @Experience  WHERE passport = @Passport")
vRP.Prepare("season_pass/resetUserPass","UPDATE season_pass SET done = @Done, experience = @Experience, completed = NULL WHERE passport = @Passport")
vRP.Prepare("season_pass/insertUserPass","INSERT IGNORE INTO season_pass(passport) VALUES(@Passport)")
vRP.Prepare("season_pass/givePremium","UPDATE season_pass SET premium = 1 WHERE passport = @Passport")
vRP.Prepare("season_pass/setCompleted","UPDATE season_pass SET completed = current_timestamp() WHERE passport = @Passport")
vRP.Prepare("season_pass/ResetSeasonPass","DELETE FROM season_pass")
-----------------------------------------------------------------------------------------------------------------------------------------
-- REP
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("reputation/init",[[
	CREATE TABLE IF NOT EXISTS `reputation` (
		`id` int(11) NOT NULL AUTO_INCREMENT,
		`Passport` int(11) NOT NULL DEFAULT 0,
		`other` int(11) NOT NULL DEFAULT 0,
		`time` int(20) NOT NULL DEFAULT 0,
		PRIMARY KEY (`id`),
		KEY `id` (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
]])

vRP.Prepare("reputation/MaisRep",[[
	ALTER TABLE `characters` ADD COLUMN IF NOT EXISTS `maisrep` INT(10) NOT NULL DEFAULT '0';
]])

vRP.Prepare("reputation/MenosRep",[[
	ALTER TABLE `characters` ADD COLUMN IF NOT EXISTS `menosrep` INT(10) NOT NULL DEFAULT '0';
]])

CreateThread(function()
	vRP.Query("reputation/init")
	vRP.Query("reputation/MaisRep")
	vRP.Query("reputation/MenosRep")
end)

vRP.Prepare("reputacao/Mais","UPDATE characters SET maisrep = maisrep + @amount WHERE id = @Passport")
vRP.Prepare("reputacao/Menos","UPDATE characters SET menosrep = menosrep + @amount WHERE id = @Passport")
vRP.Prepare("reputacao/Add","INSERT INTO reputation(Passport,other,time) VALUES(@Passport,@other,UNIX_TIMESTAMP() + 86400)")
vRP.Prepare("reputacao/Check","SELECT time FROM reputation WHERE Passport = @Passport AND other = @other ORDER BY id DESC LIMIT 1")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("premium/setPremium","INSERT INTO premium(passport,premium,expires) VALUES(@passport,@premium,DATE_ADD(CURRENT_TIMESTAMP(),INTERVAL + @Days DAY))")
vRP.Prepare("premium/getPremium","SELECT `premium`,UNIX_TIMESTAMP(expires) AS expires FROM premium WHERE passport = @passport")
vRP.Prepare("premium/deletePremium","DELETE FROM premium WHERE passport = @Passport AND `premium` = @premium")
vRP.Prepare("premium/updatePremium","UPDATE premium SET expires = DATE_ADD(CURRENT_TIMESTAMP(),INTERVAL + @Days DAY) WHERE passport = @passport AND `premium` = @premium")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ICR
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("icr/newDate","INSERT INTO icr(date) VALUES(current_timestamp())")
vRP.Prepare("icr/getDate","SELECT amount FROM icr WHERE date = @date")
vRP.Prepare("icr/addICR","UPDATE icr SET amount = amount + 1 WHERE date = @date")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOTEM
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("totem/GetAll","SELECT * FROM totem_sale")
vRP.Prepare("totem/Add","INSERT INTO totem_sale(totem_id) VALUES(@totem)")
vRP.Prepare("totem/Rem","DELETE FROM totem_sale WHERE totem_id = @totem")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("blips/getBlips","SELECT * FROM blips")
vRP.Prepare("blips/addBlip","INSERT INTO blips(owner,name,blip_id,coordinates,color) VALUES(@owner,@name,@blip_id,@coordinates,@color)")
vRP.Prepare("blips/removeBlip","DELETE FROM blips WHERE name = @name")
vRP.Prepare("blips/newName","UPDATE blips SET name = @newName WHERE name = @oldName")
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOGIN STEPS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("login_steps/getSteps","SELECT * FROM login_steps WHERE account = @AccountId")
vRP.Prepare("login_steps/AddSteps","INSERT INTO login_steps(account,action) VALUES(@AccountId,@Action)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- RELEASE PROMOTION
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("release_promotion/Add","INSERT INTO release_promotion(content,endAt,timer) VALUES(@Content,@Timer,UNIX_TIMESTAMP(STR_TO_DATE(@endAt, '%d-%m-%Y'))")
vRP.Prepare("release_promotion/Get","SELECT * FROM release_promotion WHERE endAT > CURDATE()")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROP COUNT
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("drop_count/Add","INSERT INTO drop_count(passport,reason) VALUES(@Passport,@Reason)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOVAL BANNED
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("global_banned/Add","INSERT INTO global_banned(license,reason) VALUES(@Passport,@Reason)")
vRP.Prepare("global_banned/RGet","SELECT * FROM `global_banned` WHERE `license` = ?")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("groups/AddGroups","INSERT INTO groups(`group`) VALUES(@Group) ON DUPLICATE KEY UPDATE `group` = @Group")
vRP.Prepare("groups/GetGroups","SELECT * FROM `groups`")
vRP.Prepare("user_groups/GetUserGroups","SELECT id,passport,groupId,permission,UNIX_TIMESTAMP(expires) AS expires FROM `user_groups` WHERE `passport` = @passport")
vRP.Prepare("user_groups/UpdateGroup","UPDATE `user_groups` SET `permission` = ? WHERE `passport` = ? AND `groupId` = ?")
vRP.Prepare("user_groups/UpdateGroupDays","UPDATE `user_groups` SET `permission` = ?, `expires` = DATE_ADD(CURRENT_TIMESTAMP(),INTERVAL + ? DAY) WHERE `passport` = ? AND `groupId` = ?")
vRP.Prepare("user_groups/AddGroup","INSERT INTO `user_groups`(`passport`,`groupId`,`permission`) VALUES(?,?,?)")
vRP.Prepare("user_groups/AddGroupDays","INSERT INTO `user_groups`(`passport`,`groupId`,`permission`,`expires`) VALUES(?,?,?,DATE_ADD(CURRENT_TIMESTAMP(),INTERVAL + ? DAY))")
vRP.Prepare("user_groups/RemGroup","DELETE FROM `user_groups` WHERE `passport` = ? AND `groupId` = ?")
vRP.Prepare("user_groups/ClearGroup","DELETE FROM `user_groups` WHERE `groupId` = @groupId")
vRP.Prepare("user_groups/GetAllGroup","SELECT id,groupId,passport,permission,UNIX_TIMESTAMP(expires) AS expires FROM `user_groups` WHERE `groupId` = @groupId")
vRP.Prepare("user_groups/GetAllGroupPerm","SELECT id,groupId,passport,permission,UNIX_TIMESTAMP(expires) AS expires FROM `user_groups` WHERE `groupId` = @groupId AND `permission` = @permission")
vRP.Prepare("delivery_kit/InsertKit","INSERT INTO `delivery_kit`(`AccountId`,`Info`) VALUES(@AccountId,@Info)")
vRP.Prepare("delivery_kit/DeleteKit","DELETE FROM delivery_kit WHERE AccountId = @AccountId")
vRP.Prepare("delivery_kit/GetKit","SELECT id,AccountId,Info,UNIX_TIMESTAMP(after) AS after FROM delivery_kit WHERE AccountId = @AccountId")
vRP.Prepare("accounts/UpdatePriority","UPDATE `accounts` SET `priority` = @priority WHERE `id` = @id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLE CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("vehicles/rGetChest","SELECT vehicle,plate,chest,Passport FROM `vehicles` WHERE `plate` = ?")
vRP.Prepare("vehicles/rUpdateChest","UPDATE `vehicles` SET `chest` = ? WHERE `plate` = ?")
vRP.Prepare("whitelist_kd/isWhitelisted","SELECT passport FROM `whitelist_kd` WHERE `passport` = @Passport")