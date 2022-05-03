# Project_Morse
# Morse transmitter
### Team members

* Fiala Marek
* Neradilek Adam
* Nesvadba Ondřej
* Peška Vojtěch

### Table of contents

* [Project objectives](#objectives)
* [Characters distribution](#characters)
* [Hardware description](#hardware)
* [VHDL modules description and simulations](#modules)
* [TOP module description and simulations](#top)
* [Video](#video)
* [References](#references)

<a name="objectives"></a>

## Project objectives
The main objective of our project is to program a VHDL code, which transfers any digit or letter from czech alfabet into morse code. Then implement our code via Vivado to Nexys-a7-50t board. 

The characters (digits or letters) are assigned by 16 switches on the Nexys board. The way characters are assigned is described in a table below. As soon as character is assigned, you can push the center button and entered character is in morse trasmitted via RGB LED. During the transmission, the switches are inactive and you can enter another character after the transmission is finished.


<a name="characters"></a>

## Characters distribution

![zadávání](https://user-images.githubusercontent.com/99417291/164990761-116f0b6f-d9df-4b99-b260-22a0c6d4a104.jpg)

## State diagram

![state_diagram](https://user-images.githubusercontent.com/99727489/166453574-a1011d20-a2e8-490f-8260-bdf5a4585289.jpg)

<a name="hardware"></a>

## Hardware description

1. Nexys A7 Artix-7
The Nexys A7 board is a complete, ready-to-use digital circuit development platform based on the latest Artix-7™ Field Programmable Gate Array (FPGA) from Xilinx®. With its large, high-capacity FPGA, generous external memories, and collection of USB, Ethernet, and other ports, the Nexys A7 can host designs ranging from introductory combinational circuits to powerful embedded processors. Several built-in peripherals, including an accelerometer, temperature sensor, MEMs digital microphone, a speaker amplifier, and several I/O devices allow the Nexys A7 to be used for a wide range of designs without needing any other components.

<a name="modules"></a>

## VHDL modules description and simulations

Write your text here.

<a name="top"></a>

![waves](https://github.com/onesvadba/Project_Morse/blob/main/waves.PNG)


## TOP module description and simulations

Write your text here.

<a name="video"></a>

## Video

Write your text here

<a name="references"></a>

## References

1. https://cs.wikipedia.org/wiki/Morseova_abeceda
2. https://github.com/tomas-fryza/digital-electronics-1
3. https://digilent.com/reference/programmable-logic/nexys-a7/reference-manual?redirect=1
