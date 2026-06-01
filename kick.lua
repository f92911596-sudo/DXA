-- سكربت Delta لاستقبال إشارة الطرد عبر ديسكورد
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- رابط الـ Webhook الخاص بك
local DISCORD_WEBHOOK_URL = "https://discord.com/api/webhooks/1510920930040348714/kKy6esJPnBdIdS_JRl3h6kFBSJzOwOJUCyBRvZzVLQ3X9rqaPyU-hHYBVINxhj_8mSh9"

-- تحويل الرابط للعمل عبر Proxy لتجاوز الحجب
local ProxyURL = DISCORD_WEBHOOK_URL:gsub("discord.com", "webhook.lewisakura.moe") 

print("📡 Delta Discord Listener Active... Waiting for signal")

task.spawn(function()
    -- فحص كل ثانيتين
    while task.wait(2) do 
        local success, response = pcall(function()
            return game:HttpGet(ProxyURL)
        end)
        
        -- التحقق من الاستجابة
        if success and response and response ~= "" then
            if string.find(response, "KICK_NOW") then
                print("🚨 تم استقبال إشارة الطرد! جاري الخروج...")
                LocalPlayer:Kick("\n[DSC SYSTEM]\nتم الخروج فوراً بناءً على إشارة ديسكورد!")
                break
            else
                print("📡 في انتظار الإشارة... (الوضع الحالي: سليم)")
            end
        end
    end
end)
