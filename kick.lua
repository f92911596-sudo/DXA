-- سكربت Delta المحدث للتحقق من آخر رسالة
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- رابط الـ Webhook الخاص بك
local DISCORD_WEBHOOK_URL = "https://discord.com/api/webhooks/1510920930040348714/kKy6esJPnBdIdS_JRl3h6kFBSJzOwOJUCyBRvZzVLQ3X9rqaPyU-hHYBVINxhj_8mSh9"

-- استخدام Proxy بديل ومجرب
local ProxyURL = DISCORD_WEBHOOK_URL:gsub("discord.com", "hooks.hyra.io") 

print("📡 النظام جاهز، جاري الاتصال...")

task.spawn(function()
    while task.wait(3) do 
        local success, response = pcall(function()
            -- نضيف /messages لجلب آخر الرسائل من الـ Webhook
            return game:HttpGet(ProxyURL .. "/messages")
        end)
        
        if success and response then
            -- هنا نقوم بفك تشفير الـ JSON للبحث عن الرسالة
            if string.find(response, "KICK_NOW") then
                print("🚨 إشارة الطرد تم رصدها!")
                LocalPlayer:Kick("\n[DSC SYSTEM]\nتم الطرد بنجاح!")
                break
            else
                print("📡 في انتظار الإشارة...")
            end
        else
            warn("❌ فشل الاتصال بالـ Proxy")
        end
    end
end)
