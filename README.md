![R (2)](https://github.com/Azumi67/PrivateIP-Tunnel/assets/119934376/a064577c-9302-4f43-b3bf-3d4f84245a6f)
نام پروژه : لودبالانسر UDP با تانل
---------------------------------------------------------------
![lang](https://github.com/Azumi67/PrivateIP-Tunnel/assets/119934376/627ecb66-0445-4c15-b2a0-59e02c7f7e09)
**زبان - Languages**

- [زبان English]
------------------------
![check](https://github.com/Azumi67/PrivateIP-Tunnel/assets/119934376/13de8d36-dcfe-498b-9d99-440049c0cf14)
**امکانات**
 <div dir="rtl">&bull; ساخت پرایوت ایپی و سرویس پینگ برای برقرار ماندن تانل بین دو سرور</div>
 <div dir="rtl">&bull; ساخت udp loadbalancer بدون تانل و با تانل</div>
 <div dir="rtl">&bull; تانل UDP با استفاده از FRP و UDP2RAW</div>
 <div dir="rtl">&bull; نمایش وضعیت سرویس تانل شما</div>
 <div dir="rtl">&bull; امکان ریست و حذف کردن سرویس</div>
 <div dir="rtl">&bull; وایرگارد را در سرور خارج نصب نمایید</div>
 <div dir="rtl">&bull; تانل RTT هم بعدا به اسکریپت اضافه خواهد شد.</div>
 <div dir="rtl">&bull; پشتیبانی از amd64 و arm </div>
 
 ------------------------------------------------------

<p align="right">
  <img src="https://github.com/Azumi67/udp-loadbalancer-tunnel/assets/119934376/57112532-6845-4eab-9b42-1b680d7d88a5" alt="Image" /> <div dir="rtl">&bull; این پروژه اموزشی هست و اگر خطایی در لودبالانس دیدید لطفا به من اطلاع بدید</div>
</p> 
  <div dir="rtl">&bull; برای اضافه کردن ایپی 6 native میتوانید از اسکریپت Opiran استفاده نمایید. لطفا به قسمت اسکریپت های کارامد رجوع کنید.</div>
   <div dir="rtl">&bull; مسیر nginx در این directory میباشد >/etc/nginx/nginx.conf </div>
 
  -----------------------------------------
  
  ![6348248](https://github.com/Azumi67/PrivateIP-Tunnel/assets/119934376/398f8b07-65be-472e-9821-631f7b70f783)
**آموزش**

 

**لود بالانس با تانل**
 

 <p align="right">
  <img src="https://github.com/Azumi67/udp-loadbalancer-tunnel/assets/119934376/39c90b1c-f7ba-498f-9c61-9cb3de3edea6" alt="Image" />
</p>
 <div dir="rtl">&bull;اگر به تنهایی از لودبالانس میخواهید استفاده کنید، تنها گزینه سوم را انتخاب کنید. در این کانفیگ از لود بالانس و تانل استفاده شده است</div>
  <div dir="rtl">&bull;از گزینه 4، لودبالانس و تانل frp استفاده کردیم.</div>
   <div dir="rtl">&bull; پورت وایرگارد خارج و پورت لود بالانس را وارد نمایید.</div>
    <div dir="rtl">&bull; در صورتی که از لودبالانس بدون تانل میخواهید استفاده کنید، پورت لودبالانس، پورت جدید شما برای وایرگارد میباشد</div>
     <div dir="rtl">&bull;اگر از لود بالانس و تانل میخواهید استفاده کنید، پورت لودبالانس، پورت شما برای تانل خواهد بود( جایگزین پورت خارج شما میشود)</div>
      <div dir="rtl">&bull;تعداد ایپی 6 خارج برای لود بالانس را انتخاب کنید. از ایپی 6 native خارج استفاده کنید</div>
       <div dir="rtl">&bull; پورت لود بالانس شما در اخر به شما نمایش داده خواهد شد</div>
        <div dir="rtl">&bull; تست انجینکس در صورت درستی مراحل طی شده؛ به صورت successful نمایش داده میشود.</div>




----------------------
**لود بالانس با تانل FRP - سرور ایران**
<p align="right">
  <img src="https://github.com/Azumi67/udp-loadbalancer-tunnel/assets/119934376/cacbabab-3c7d-4188-a3bc-25613c832341" alt="Image" />
</p>
 <div dir="rtl">&bull; تانل را اول بر روی سرور ایران کانفیگ نمایید</div>
 <div dir="rtl">&bull; پورت و توکن تانل را وارد نمایید (مقدار یکسان در سرور خارج و ایران قرار بدهید)</div>
  <div dir="rtl">&bull; پورت لودبالانس را در سرور ایران وارد نمایید</div>
   <div dir="rtl">&bull; پورت جدید وایرگاردتون رو وارد نمایید. اینجا به نام پورت وایرگارد ایران میباشد</div>

--------------------------------------
**لود بالانس با تانل FRP - سرور خارج**
<p align="right">
  <img src="https://github.com/Azumi67/udp-loadbalancer-tunnel/assets/119934376/6d370703-4a13-474f-a544-50bb5714540f" alt="Image" />
</p>
 <div dir="rtl">&bull; چون لود بالانس تک پورت استفاده میکنیم پس تنها به یک ایپی 6 برای سرور ایران و خارج نیاز داریم</div>
  <div dir="rtl">&bull; ایپی 6 native ایران یا ایپی پرایوت ایران را وارد نمایید</div>
   <div dir="rtl">&bull; در صورتی که برای iran ipv6 address از ایپی پرایوت استفاده کردید برای kharej ipv6 address .هم از ایپی پرایوت استفاده نمایید</div>
    <div dir="rtl">&bull; همینطور اگر برای iran ipv6 address از ایپی 6 native استفاده کردید، برای kharej ipv6 address هم از ایپی 6 native استفاده نمایید</div>
     <div dir="rtl">&bull; در صورت استفاده از ایپی 6 native برای تانل ،برای kharej ipv6 address همچنین میتوانید از 127.0.0.1 استفاده نمایید اما برای iran ipv6 address حتما از ایپی 6 سرور ایران استفاده نمایید</div>
      <div dir="rtl">&bull; پورت و توکن تانل رو مانند سرور ایران وارد نمایید</div>
 <div dir="rtl">&bull; پورت لودبالانس و پورت جدید وایرگارد خودتون رو که با نام iran wireguard port میباشد را وارد نمایید. مانند سرور ایران</div>


---------------------------------

**لود بالانس با تانل udp2raw - سرور خارج**

<p align="right">
  <img src="https://github.com/Azumi67/udp-loadbalancer-tunnel/assets/119934376/d77d3170-7a3f-4404-a990-5331efe9f45e" alt="Image" />
</p>

  <div dir="rtl">&bull; برای این تانل، نخست لود بالانس را اجرا نمایید و پورت لود بالانس را برای تانل یادداشت نمایید و سپس سرور خارج را برای تانل انتخاب نمایید</div>
 <div dir="rtl">&bull; پورت تانل را وارد نمایید</div>
  <div dir="rtl">&bull; پورتی که برای لودبالانس انتخاب کردید را هم در تانل udp2raw در سرور خارج وارد نمایید</div>
   <div dir="rtl">&bull; در این تانل، پورت جدید وایرگارد شما همان پورت لودبالانس خواهد بود</div>
 
------------------------------------------------------------------------------
**لود بالانس با تانل udp2raw - سرور ایران**
<p align="right">
  <img src="https://github.com/Azumi67/udp-loadbalancer-tunnel/assets/119934376/1842bfa6-eafd-4392-8165-aaad32888b29" alt="Image" />
</p>

  <div dir="rtl">&bull; برای این تانل، نخست لود بالانس را اجرا نمایید و پورت لود بالانس را برای تانل یادداشت نمایید و سپس سرور ایران را برای تانل انتخاب نمایید</div>
  <div dir="rtl">&bull; سپس یا از ایپی پرایوت یا ipv6 native برای تانل استفاده نمایید.</div>
  <div dir="rtl">&bull; اگر میخواهید از پرایوت ایپی استفاده نمایید، قبل از اجرای لود بالانس، از طریق گزینه دوم پرایوت ایپی خارج و ایران را بسازید.</div>
 <div dir="rtl">&bull; پورت تانل را وارد نمایید</div>
  <div dir="rtl">&bull; پورتی که برای لودبالانس انتخاب کردید را هم در تانل udp2raw در سرور ایران وارد نمایید</div>
   <div dir="rtl">&bull; در این تانل، پورت جدید وایرگارد شما همان پورت لودبالانس خواهد بود</div>
    <div dir="rtl">&bull; در قسمت kharej ipv6 address ، ایپی 6 native خارج یا ایپی پرایوت خارج را وارد نمایید</div>


---------------------------------------------------------------------------

**پرایوت ایپی**

  <p align="right">
  <img src="https://github.com/Azumi67/PrivateIP-Tunnel/assets/119934376/d92b4e8f-b368-4938-b639-5efea493e184" alt="Image" />
</p>
<div dir="rtl">&bull; ساخت پرایوت ایپی : از سرور خارج شروع کنید.</div>
 <div dir="rtl">&bull; ایپی 4 خارج و ایران را وارد نمایید</div> 
   <div dir="rtl">&bull; تعداد ایپی پرایوتی که نیاز دارید را وارد نمایید</div>
    <div dir="rtl">&bull; ایپی های ساخته شده را در notepad برای استفاده در تانل بنویسید</div>
     <div dir="rtl">&bull; به صورت اتوماتیک ایپی پرایوت وسرویس پینگ به منظور جلوگیری از اختلال برای شما ساخته خواهد شد</div>
      <div dir="rtl">&bull; سپس همین مراحل را برای سرور ایران هم انجام بدهید</div>


-------------------------------
**اسکرین شات**
<details>
  <summary align="right">Click to reveal image</summary>
  
  <p align="right">
    <img src="https://github.com/Azumi67/udp-loadbalancer-tunnel/assets/119934376/9d7d38c2-4e03-4d4c-bbb4-a32bb301cdb2" alt="menu screen" />
  </p>
</details>


------------------------------------------
![scri](https://github.com/Azumi67/FRP-V2ray-Loadbalance/assets/119934376/cbfb72ac-eff1-46df-b5e5-a3930a4a6651)
**اسکریپت های کارآمد :**
- این اسکریپت ها optional میباشد.


 
 Opiran Script
```
apt install curl -y && bash <(curl -s https://raw.githubusercontent.com/opiran-club/VPS-Optimizer/main/optimizer.sh --ipv4)
```

Hawshemi script

```
wget "https://raw.githubusercontent.com/hawshemi/Linux-Optimizer/main/linux-optimizer.sh" -O linux-optimizer.sh && chmod +x linux-optimizer.sh && bash linux-optimizer.sh
```

<div dir="rtl">&bull; اضافه کردن ایپی 6 اضافه</div>
 
  
```
bash <(curl -s -L https://raw.githubusercontent.com/opiran-club/softether/main/opiran-seth)
```
-----------------------------------------------------
![R (a2)](https://github.com/Azumi67/PrivateIP-Tunnel/assets/119934376/716fd45e-635c-4796-b8cf-856024e5b2b2)
**اسکریپت من**
------------------------

```
apt install curl -y && bash <(curl -Ls https://raw.githubusercontent.com/Azumi67/udp-loadbalancer-tunnel/main/udp.sh --ipv4)
```


---------------------------------------------
![R (7)](https://github.com/Azumi67/PrivateIP-Tunnel/assets/119934376/42c09cbb-2690-4343-963a-5deca12218c1)
**تلگرام** 
![R (6)](https://github.com/Azumi67/FRP-V2ray-Loadbalance/assets/119934376/f81bf6e1-cfed-4e24-b944-236f5c0b15d3) [اپیران](https://github.com/opiran-club)

---------------------------------
![R23 (1)](https://github.com/Azumi67/FRP-V2ray-Loadbalance/assets/119934376/18d12405-d354-48ac-9084-fff98d61d91c)
**سورس ها**


![R (6)](https://github.com/Azumi67/FRP-V2ray-Loadbalance/assets/119934376/be0dd34c-7b47-4d93-904c-eecf013d7b06) [سورس های FRP](https://github.com/fatedier/frp)

![R (9)](https://github.com/Azumi67/6TO4-GRE-IPIP-SIT/assets/119934376/4758a7da-ab54-4a0a-a5a6-5f895092f527)[سورس های Hwashemi](https://github.com/hawshemi/Linux-Optimizer)

![R (9)](https://github.com/Azumi67/FRP-V2ray-Loadbalance/assets/119934376/33388f7b-f1ab-4847-9e9b-e8b39d75deaa) [سورس های OPIRAN](https://github.com/opiran-club)

![R (6)](https://github.com/Azumi67/PrivateIP-Tunnel/assets/119934376/8a486a00-c6c3-4b30-ba47-3416f9bc2ab3)[سورس udp2raw](https://github.com/wangyu-/udp2raw/)

-----------------------------------------------------

![youtube-131994968075841675](https://github.com/Azumi67/FRP-V2ray-Loadbalance/assets/119934376/24202a92-aff2-4079-a6c2-9db14cd0ecd1)
**ویدیوی آموزش**

-----------------------------------------


