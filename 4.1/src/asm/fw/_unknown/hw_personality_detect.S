/* hw_personality_detect @ 0x8dffd8, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   HW personality is DEVICE
 *   HW personality is ROOT
 * Зовут его: sdp_gpio__boot_init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, hw_personality__read_strap
 */
	.section .text.hw_personality_detect,"ax",@progbits
	.global hw_personality_detect
hw_personality_detect:
	.global L_8dffd8
L_8dffd8:
	push_s blink
L_8dffda:
	bl L_8c02c4
L_8dffde:
	mov_s r0,0x800ce8
L_8dffe4:
	mov_s r1,0x80345c
L_8dffea:
	ld_s r1,[r1,0x18]
L_8dffec:
	ld_s r0,[r0]
L_8dffee:
	lsr_s r1,r1,0xd
L_8dfff0:
	bmsk_s r1,r1,0x1
L_8dfff2:
	mov_s r13,0x880a3c
L_8dfff8:
	mov_s r14,0x0
L_8dfffa:
	breq r1,0x1,L_8e0006
L_8dfffe:
	bl.d L_8d1578
L_8e0002:
	bmsk_s r0,r0,0x4
L_8e0004:
	brne_s r0,0,L_8e0018
	.global L_8e0006
L_8e0006:
	mov_s r2,0x1008214
L_8e000c:
	mov_s r0,0x0
L_8e000e:
	bl.d L_8edfb0
L_8e0012:
	mov_s r1,0x2
L_8e0014:
	st_s r14,[r13,0x7c]
L_8e0016:
	b_s L_8e002a
	.global L_8e0018
L_8e0018:
	mov_s r2,0x1008230
L_8e001e:
	mov_s r0,r14
L_8e0020:
	bl.d L_8edfb0
L_8e0024:
	mov_s r1,0x2
L_8e0026:
	mov_s r0,0x1
L_8e0028:
	st_s r0,[r13,0x7c]
	.global L_8e002a
L_8e002a:
	b L_8c0334
L_8e002e:
	nop_s
