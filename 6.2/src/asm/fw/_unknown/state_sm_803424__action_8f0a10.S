/* state_sm_803424__action_8f0a10 @ 0x8f0a10, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: ftm__set_shared_active_flag
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global state_sm_803424__action_8f0a10
state_sm_803424__action_8f0a10:
	.global L_8f0a10
L_8f0a10:
	mov_s r2,r1
L_8f0a12:
	ld_s r1,[r0,0x1c]
L_8f0a14:
	ld_s r0,[gp,-0x74]
L_8f0a16:
	b.d L_8cb550
L_8f0a1a:
	add_s r0,r0,0x20
