/* mac__toggle_880288_b1 @ 0x8c7044, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf_kill__irq_task, rf_kill_sm__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__toggle_880288_b1
mac__toggle_880288_b1:
	.global L_8c7044
L_8c7044:
	mov_s r1,0x0
	.global L_8c7046
L_8c7046:
	mov_s r2,0x880280
L_8c704c:
	ld_s r0,[r2,0x8]
L_8c704e:
	btst_s r0,0x0
L_8c7050:
	ld_s r0,[r2,0x8]
L_8c7052:
	bne_s L_8c7060
L_8c7054:
	bset_s r0,r0,0x1
L_8c7056:
	st_s r0,[r2,0x8]
L_8c7058:
	ld_s r0,[r2,0x8]
L_8c705a:
	bbit1 r0,0x0,L_8c706c
L_8c705e:
	b_s L_8c706a
	.global L_8c7060
L_8c7060:
	bclr_s r0,r0,0x1
L_8c7062:
	st_s r0,[r2,0x8]
L_8c7064:
	ld_s r0,[r2,0x8]
L_8c7066:
	bbit0 r0,0x0,L_8c706c
	.global L_8c706a
L_8c706a:
	mov_s r1,0x1
	.global L_8c706c
L_8c706c:
	breq_s r1,0,L_8c7046
L_8c706e:
	j_s [blink]
