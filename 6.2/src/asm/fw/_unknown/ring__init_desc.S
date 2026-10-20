/* ring__init_desc @ 0x8d8b00, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__build_cmd_rings, mbox__init_descriptor
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, ba_sm__prepare_ba_td
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ring__init_desc
ring__init_desc:
	.global L_8d8b00
L_8d8b00:
	push_s blink
L_8d8b02:
	bl L_8c01e0
L_8d8b06:
	mov_s r14,r5
L_8d8b08:
	st_s r1,[r0]
L_8d8b0a:
	st_s r1,[r0,0x4]
L_8d8b0c:
	add_s r1,r1,r2
L_8d8b0e:
	st_s r1,[r0,0x8]
L_8d8b10:
	st_s r3,[r0,0xc]
L_8d8b12:
	st r4,[r0, 0x10]
L_8d8b16:
	mov_s r1,0x0
L_8d8b18:
	st_s r1,[r0,0x18]
L_8d8b1a:
	st_s r1,[r0,0x1c]
L_8d8b1c:
	cmp r6,0x1
L_8d8b20:
	st r6,[r0, 0x14]
L_8d8b24:
	bl.eq.d L_8e0d6c
L_8d8b28:
	mov.eq r1,r14
L_8d8b2c:
	b L_8c024c
