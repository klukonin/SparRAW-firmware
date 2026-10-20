/* clk__gate_880b00 @ 0x928d40, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw__bring_up_phy_dma
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global clk__gate_880b00
clk__gate_880b00:
	.global L_928d40
L_928d40:
	mov r2,0x1b0
L_928d44:
	mov r1,0x880800
L_928d4c:
	breq.d r0,0x0,L_928d68
L_928d50:
	mov r4,-0x1b1
L_928d54:
	ld.as r5,[r1,0xc0]
L_928d58:
	and r4,r4,r5
L_928d5c:
	or r2,r2,r4
L_928d60:
	st.as r2,[r1,0xc0]
L_928d64:
	j [blink]
	.global L_928d68
L_928d68:
	ld.as r3,[r1,0xc0]
L_928d6c:
	and r3,r3,r4
L_928d70:
	st.as r3,[r1,0xc0]
L_928d74:
	j_s [blink]
L_928d76:
	nop_s
