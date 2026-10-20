/* ss__copy_cfg_from_cmd @ 0x93e150, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: memcpy_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ss__copy_cfg_from_cmd
ss__copy_cfg_from_cmd:
	.global L_93e150
L_93e150:
	push_s blink
L_93e152:
	mov_s r1,r0
L_93e154:
	ld_s r0,[r0,0x4c]
L_93e156:
	breq_s r0,0,L_93e164
L_93e158:
	mov_s r0,0x802a20
L_93e15e:
	bl.d L_920330
L_93e162:
	mov_s r2,0x4c
	.global L_93e164
L_93e164:
	pop_s blink
L_93e166:
	j_s [blink]
