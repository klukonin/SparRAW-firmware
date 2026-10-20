/* pring__init_pool @ 0x8d8cb0, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: disc_sm__sw_data_stopped
 * Зовёт сам: mem_pool__init, pring__set_done_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pring__init_pool
pring__init_pool:
	.global L_8d8cb0
L_8d8cb0:
	push_s blink
L_8d8cb2:
	mov_s r1,0x0
L_8d8cb4:
	mov_s r0,0x804e3c
L_8d8cba:
	st_s r1,[r0,0x24]
L_8d8cbc:
	mov_s r1,0x804c40
L_8d8cc2:
	mov_s r0,0x804da8
L_8d8cc8:
	mov_s r2,0x28
L_8d8cca:
	bl.d L_8c7cf8
L_8d8cce:
	mov_s r3,0x9
L_8d8cd0:
	mov_s r0,0x9200
L_8d8cd6:
	bl.d L_8e7334
L_8d8cda:
	mov_s r1,0x0
L_8d8cdc:
	pop_s blink
L_8d8cde:
	j_s [blink]
