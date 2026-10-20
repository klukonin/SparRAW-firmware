/* find_mngr__del_discovery_bcon @ 0x8c8d6c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND:: >>>>>>>> DEL DMG DISCOVERY BEACOM <<<<<<<<
 * Зовут его: find_main_sm__stop, find_main_sm__stop_searching, state_sm_8030f4__action_8f9ce0
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, tx_bcon__del_bcon
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_mngr__del_discovery_bcon
find_mngr__del_discovery_bcon:
	.global L_8c8d6c
L_8c8d6c:
	push_s blink
L_8c8d6e:
	push_s r13
L_8c8d70:
	mov_s r13,r0
L_8c8d72:
	ld_s r0,[r0,0x44]
L_8c8d74:
	breq_s r0,0,L_8c8d98
L_8c8d76:
	mov_s r1,0x1017b1c
L_8c8d7c:
	bl.d L_8dcba8
L_8c8d80:
	mov_s r0,0x2c
L_8c8d82:
	mov_s r0,0x0
L_8c8d84:
	st_s r0,[r13,0x44]
L_8c8d86:
	bl.d L_8c8be8
L_8c8d8a:
	ld_s r0,[r13,0x48]
L_8c8d8c:
	ld_s r1,[r13,0x48]
L_8c8d8e:
	add r1,r1,0x14f
L_8c8d92:
	ldb_s r0,[r1]
L_8c8d94:
	bclr_s r0,r0,0x1
L_8c8d96:
	stb_s r0,[r1]
	.global L_8c8d98
L_8c8d98:
	b L_8c025c
