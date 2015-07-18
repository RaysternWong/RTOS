  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global  waitForTaskSwitch
  .global  SysTick_Handler
  .extern taskOneStack
  .extern taskTwoStack

  .section  .text.waitForTaskSwitch
  .type  waitForTaskSwitch, %function
waitForTaskSwitch:
  ldr  r0, =#0x00000000
  ldr  r1, =#0x11111111
  ldr  r2, =#0x22222222
  ldr  r3, =#0x33333333
  ldr  r4, =#0x44444444
  ldr  r5, =#0x55555555
  ldr  r6, =#0x66666666
  ldr  r7, =#0x77777777
  ldr  r8, =#0x88888888
  ldr  r9, =#0x99999999
  ldr  r10, =#0xaaaaaaaa
  ldr  r11, =#0xbbbbbbbb
  ldr  r12, =#0xcccccccc
  ldr   lr, =#0xdeadface
   push  {r0}
  b		.
  .align 8
  .type SysTick_Handler, %function

  .equ TCB_NEXT,  0
  .equ TCB_NAME,  4
  .equ TCB_SP  ,  8


SysTick_Handler:
    push 	{r4-r11}
    ldr 	 r0, =mainTcb
    movs	 r1, #0
	add		 r1, sp
	str 	 r1, [r0, #TCB_SP]
	ldr 	 r0, =taskOneTcb
	ldr 	 sp, [r1, #TCB_SP]
	pop 	{r4-r11}
	pop 	{r0-r3}
	pop 	{r12}
    bx      lr

// extra space
//     XPSR
//     PC
//     LR
//     r12
//     r3
//     r2
//     r1
//     r0
//     r11
//     r10
//     r9
//     r8
//     r7
//     r6
//     r5
//     r4    <-	sp
