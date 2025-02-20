# 🧠 Base Loup Network
Descrição: Base Loup Network

```
- Adicionado novos mapas.
```

# ⚙️ Instructions:
```
1. Clique no botão verde \"Code\"
2. Clique em \"Download ZIP\"
3. Abra o arquivo zip e extraia a pasta \"lxpnetwork-main\" na pasta de recursos do seu FiveM\"
4. Renomeie o recurso de  \""lxpnetwork-main\" para \""lxpnetwork\" (remova -main)\"
5. Renomeie o arquivo server-sample.cfg para arquivo server.cfg
6. Abra o arquivo server.cfg e coloque suas configurações.
7. Abra o start.bat e configure seu txadmin.
```
# 🗺️ Maps not Included

```
[Gabz Subscription] (https://fivem.gabzv.com)
[Map4all Subscription] (https://fivem.map4all-shop.com/) 
[Tabac Redwood] (https://bit.ly/42cSUvL)
[Bungalow Village] (https://youneedit.tebex.io/package/5226877)
[CaveMiningMLO] (https://www.k4mb1maps.com/package/4881018)
```

# 📖 Server Events
```

vRP.Prepare(Name,Query)

vRP.Query(Name,Params)

vRP.Identities(Source)

vRP.Archive(Archive,Text)

vRP.Banned(License)

vRP.HardwareBanned(Hardwareid)




vRP.Account(License)

vRP.UserData(Passport,Key)

vRP.InsidePropertys(Passport,Coords)

vRP.Inventory(Passport)

vRP.SaveTemporary(Passport,source,Route)

vRP.ApplyTemporary(Passport,source)

vRP.SkinCharacter(Passport,Hash)

vRP.Passport(source)

vRP.Players()

vRP.Source(Passport)

vRP.Datatable(Passport)

vRP.Kick(source,Reason)

vRP.CharacterChosen(source,Passport,Model)

vRP.WeedReturn(Passport)

vRP.WeedTimer(Passport,Time)

vRP.ChemicalReturn(Passport)

vRP.ChemicalTimer(Passport,Time)

vRP.AlcoholReturn(Passport)

vRP.AlcoholTimer(Passport,Time)

vRP.Groups()

vRP.DataGroups(Permission)

vRP.GetUserType(Passport,Type)

vRP.Hierarchy(Permission)

vRP.NumPermission(Permission)

vRP.ServiceToggle(Source,Passport,Permission,Silenced)

vRP.ServiceEnter(Source,Passport,Permission,Silenced)

vRP.ServiceLeave(Source,Passport,Permission,Silenced)

vRP.SetPermission(Passport,Permission,Level,Mode)

vRP.RemovePermission(Passport,Permission)

vRP.HasPermission(Passport,Permission,Level)

vRP.HasGroup(Passport,Permission,Level)

vRP.HasService(Passport,Permission)

vRP.FalseIdentity(Passport)

vRP.Identity(Passport)

vRP.InitPrison(Passport,Amount)

vRP.UpdatePrison(Passport,Amount)

vRP.UpgradeSpending(Passport,Amount)

vRP.DowngradeSpending(Passport,Amount)

vRP.UpgradeCardlimit(Passport,Amount)

vRP.DowngradeCardlimit(Passport,Amount)

vRP.UpgradeChars(source)

vRP.UserGemstone(License)

vRP.UpgradeGemstone(Passport,Amount)

vRP.UpgradeNames(Passport,Name,Name2)

vRP.UpgradePhone(Passport,Phone)

vRP.PassportPlate(Plate)

vRP.UserPhone(Phone)

vRP.GenerateString(Format)

vRP.GeneratePlate()

vRP.GeneratePhone()

vRP.ConsultItem(Passport,Item,Amount)

vRP.GetWeight(Passport)

vRP.SetWeight(Passport,Amount)

vRP.RemoveWeight(Passport,Amount)

vRP.SwapSlot(Passport,Slot,Target)

vRP.InventoryWeight(Passport)

vRP.CheckDamaged(Item)

vRP.ChestWeight(Data)

vRP.InventoryItemAmount(Passport,Item)

vRP.InventoryFull(Passport,Item)

vRP.ItemAmount(Passport,Item)

vRP.GiveItem(Passport,Item,Amount,Notify,Slot)

vRP.GenerateItem(Passport,Item,Amount,Notify,Slot)

vRP.MaxItens(Passport,Item,Amount)

vRP.TakeItem(Passport,Item,Amount,Notify,Slot)

vRP.RemoveItem(Passport,Item,Amount,Notify)

vRP.GetSrvData(Key,Save)

vRP.SetSrvData(Key,Data,Save)

vRP.RemSrvData(Key,Save)

tvRP.invUpdate(Slot,Target,Amount)

vRP.TakeChest(Passport,Data,Amount,Slot,Target)

vRP.StoreChest(Passport,Data,Amount,Weight,Slot,Target)

vRP.UpdateChest(Passport,Data,Slot,Target,Amount)

vRP.DirectChest(Chest,Slot,Amount)

vRP.GiveBank(Passport,Amount)

vRP.RemoveBank(Passport,Amount)

vRP.GetBank(source)

vRP.GetFine(source)

vRP.GiveFine(Passport,Amount)

vRP.RemoveFine(Passport,Amount)

vRP.PaymentGems(Passport,Amount)

vRP.PaymentBank(Passport,Amount,IgnoreLimit)

vRP.PaymentFull(Passport,Amount,IgnoreLimit)

vRP.WithdrawCash(Passport,Amount)

vRP.ClearInventory(Passport)

vRP.UpgradeThirst(Passport,Amount)

vRP.UpgradeHunger(Passport,Amount)

vRP.UpgradeStress(Passport,Amount)

vRP.DowngradeThirst(Passport,Amount)

vRP.DowngradeHunger(Passport,Amount)

vRP.DowngradeStress(Passport,Amount)

tvRP.Foods()

vRP.GetHealth(source)

vRP.ModelPlayer(source)

vRP.GetExperience(Passport,Work)

vRP.PutExperience(Passport,Work,Number)

vRP.SetArmour(source,Amount)

vRP.Teleport(source,x,y,z)

vRP.GetEntityCoords(source)

vRP.InsideVehicle(source)

tvRP.CreatePed(Model,x,y,z,heading,typ)

tvRP.CreateObject(Model,x,y,z,Weapon)

vRP.SetPremium(source)

vRP.UpgradePremium(source)

vRP.UserPremium(Passport)

vRP.LicensePremium(License)

vRP.UpdateRolepass(source,Day)

vRP.CheckRolepass(source)

vRP.Request(source,Message,Accept,Reject)

vRP.Revive(source,Health,Arena)


-- Client Events

tvRP.BlipAdmin()

tvRP.ClosestPeds(Radius)

tvRP.ClosestPed(Radius)

tvRP.Players()

tvRP.PlaySound(Dict,Name)

tvRP.ClosestVehicle(Radius)

tvRP.VehicleList(Radius)

tvRP.VehicleName()

tvRP.VehicleModel(Vehicle)

tvRP.LastVehicle(Name)

tvRP.createObjects(Dict,Anim,Prop,Flag,Hands,Height,Pos1,Pos2,Pos3,Pos4,Pos5)

tvRP.removeObjects(Mode)

tvRP.noClip()

tvRP.objectCoords(Model)

tvRP.playAnim(Upper,Sequency,Loop)

tvRP.stopAnim(Upper)

tvRP.AnimActive()

tvRP.SetHealth(Health)

tvRP.UpgradeHealth(Number)

tvRP.DowngradeHealth(Number)

tvRP.Skin(Hash)


-- Resource: Bank

exports["bank"]:AddTaxs(Passport: int,Name: string,Value: int,Message: string)

exports["bank"]:AddTransactions(Passport: int,Type: string,Value: int)

exports["bank"]:AddFines(Passport: int,OtherPassport: int,Value: int,Message: string)

exports["bank"]:Taxs(Passport: int)

exports["bank"]:Fines(Passport: int)

exports["bank"]:Invoices(Passport: int)

exports["bank"]:Dependents(Passport: int)

exports["bank"]:Transactions(Passport: int,Limit: int)


-- MySQL

ALTER TABLE characters ADD created int(20) Default 0 NOT NULL;
```

## Se precisar de ajuda.
[https://discord.gg/UuftznYajU](https://discord.gg/xA9qZtAx2w)






