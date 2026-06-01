-- سكربت Delta لاستقبل إشارة الطرد عبر ديسكورد
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ضع رابط الـ Webhook الفعلي الخاص بك هنا
local DISCORD_WEBHOOK_URL = "رابط_الـ_Webhook_هنا" 

-- تحويل تلقائي للرابط عبر Proxy ليتوافق مع قيود روبلوكس وديسكورد
local ProxyURL = DISCORD_WEBHOOK_URL:gsub("discord.com", "webhook.lewisakura.moe") 

print("📡 Delta Discord Listener Active... Waiting for signal")

task.spawn(function()
    while task.wait(0.5) do -- فحص فائق السرعة كل نصف ثانية
        local success, response = pcall(function()
            return game:HttpGet(ProxyURL)
        end)
        
        -- التحقق من استقبال شفرة الطرد
        if success and response and string.find(response, "KICK_NOW") then
            print("🚨 تم استقبال الإشارة من ديسكورد! جاري الخروج...")
            LocalPlayer:Kick("\n[DSC SYSTEM]\nتم الخروج فوراً بناءً على إشارة ديسكورد من الماب الأساسي!")
            break
        end
    end
end)
