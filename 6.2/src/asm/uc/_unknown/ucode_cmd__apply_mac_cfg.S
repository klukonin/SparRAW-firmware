/* ucode_cmd__apply_mac_cfg @ 0x92f320, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x00_handler
 * Зовёт сам: __ld_r13_to_r13_ret, mac__program_886e0c_20b, memcpy_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd__apply_mac_cfg
ucode_cmd__apply_mac_cfg:
	.global L_92f320
L_92f320:
	push_s blink
L_92f322:
	push_s r13
L_92f324:
	mov_s r1,r0
L_92f326:
	mov_s r13,0x802588
L_92f32c:
	mov_s r0,r13
L_92f32e:
	bl.d L_920330
L_92f332:
	mov_s r2,0x30
L_92f334:
	bl.d L_92f1a0
L_92f338:
	mov_s r0,r13
L_92f33a:
	b L_9202ac
L_92f33e:
	nop_s
