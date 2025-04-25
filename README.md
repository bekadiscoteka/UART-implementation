
# 🔍 **Auto Baud Rate Detector (500 – 450000 baud)**

This FPGA module **automatically detects the baud rate** of a connected device (within the range **500 to 450000**) and enables reliable UART communication without requiring manual configuration.

---

## 📌 **Overview**

This design:

- Detects **baud rate automatically** from incoming serial data.
- **Works without parity**.
- Assumes **8 data bits** (parameterized internally, but fixed for this design).
- **No need to configure beforehand** — just connect and reset.

---

## ⚙️ **How It Works**

### 🔁 Step-by-step Usage:

1. **Reset** the system and **send any data** from the connected device to the FPGA.
2. Wait until the **`ready` pin lights up** — this means the baud rate has been detected successfully.
3. Start communicating at the **detected baud rate**.
4. ⚠️ **Changing the baud rate?**
   - Just **reset the FPGA** and **repeat Step 1**.

> The module requires only a few initial characters to lock onto the correct baud rate.

---

## ⚠️ **Limitations**

- **Parity check is not supported.**
- **Data bits are fixed to 8**, although internally this is a parameter.

---

## 🎥 **Demo**

Watch it in action:  
[![Demo Video](https://img.youtube.com/vi/HNC9ARV29Qs/0.jpg)](https://youtu.be/HNC9ARV29Qs?si=Q1hFCuhOhmJZtufv)

---

## 💡 **Use Cases**

- Debugging serial devices with unknown settings
- Auto-detecting terminals or microcontrollers
- Dynamic communication interfaces in embedded systems



## 🚀 **Getting Started**

1. Clone the repo and open in your FPGA toolchain.
2. Add your own UART RX line.
3. Hook up the `ready` signal.
4. Reset & send any data — you're set!
