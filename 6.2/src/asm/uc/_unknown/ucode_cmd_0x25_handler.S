/* ucode_cmd_0x25_handler @ 0x93b1f8, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: aw_ie__copy_to_bcon, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x25_handler
ucode_cmd_0x25_handler:
	.global L_93b1f8
L_93b1f8:
	push_s blink
L_93b1fa:
	ld_s r1,[r0]
L_93b1fc:
	cmp r1,0x9d
L_93b200:
	beq_s L_93b20c
L_93b202:
	mov_s r0,blink
L_93b204:
	bl.d L_926618
L_93b208:
	mov_s r1,0x87
L_93b20a:
	b_s L_93b21a
	.global L_93b20c
L_93b20c:
	mov_s r2,0x802f80
L_93b212:
	add_s r1,r0,0x4
L_93b214:
	bl.d L_934d54
L_93b218:
	mov_s r0,r2
	.global L_93b21a
L_93b21a:
	pop_s blink
L_93b21c:
	j_s [blink]
L_93b21e:
	nop_s
