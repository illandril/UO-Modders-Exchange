SAInspiredPaperdollSwordWeaponIconPack = {}

SAInspiredPaperdollSwordWeaponIconPack.prefix = "SAInspiredPaperdollSwordWeaponIconPack_"
SAInspiredPaperdollSwordWeaponIconPack.textures = {"axe", "battleaxe", "bladedstaff", "boneharvester", "broadsword", "cleaver", "crescentblade", "cutlass", "daisho", "elvenmachete", "executionersaxe", "halberd", "katana", "largebattleaxe", "longsword", "nodachi", "ornateaxe", "radiantscimitar", "runeblade", "scimitar", "scythe", "twohandedaxe", "vikingsword", "wakizashi"}

function SAInspiredPaperdollSwordWeaponIconPack.Initialize()
    for i,v in ipairs( SAInspiredPaperdollSwordWeaponIconPack.textures ) do
        IconLoader.AddIconData( SAInspiredPaperdollSwordWeaponIconPack.prefix..v )
    end
end

















