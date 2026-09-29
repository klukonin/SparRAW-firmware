/* find_mngr__listen_start @ 0x8d7de4, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND:: Listen for %d msec.
 *   FIND:: Start LISTENING on channel %d for %d msec.
 * Зовут его: find_mng__listen
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__inject_event, fw_log__emit1, fw_log__emit2, lmac_if_discovery_mode_cfg_handler, u_schd__schedule
 */
	.section .text.find_mngr__listen_start,"ax",@progbits
	.global find_mngr__listen_start
find_mngr__listen_start:
	.global L_8d7de4
L_8d7de4:
	push_s blink
L_8d7de6:
	bl L_8c02c4
L_8d7dea:
	mov_s r13,r0
L_8d7dec:
	mov_s r14,r1
L_8d7dee:
	mov_s r0,0x1
L_8d7df0:
	bl.d L_8d84a8
L_8d7df4:
	mov_s r1,0x0
L_8d7df6:
	add r0,r13,0x1c
L_8d7dfa:
	mov_s r1,0x0
L_8d7dfc:
	mov_s r2,r1
L_8d7dfe:
	mov_s r3,r1
L_8d7e00:
	bl.d L_8d6a1c
L_8d7e04:
	mov_s r4,r1
L_8d7e06:
	mov_s r2,0x1013f24
L_8d7e0c:
	mov_s r0,0xc
L_8d7e0e:
	mov_s r1,0x2
L_8d7e10:
	bl.d L_8edfcc
L_8d7e14:
	mov_s r3,r14
L_8d7e16:
	breq_s r14,0,L_8d7e4c
L_8d7e18:
	mul64 r14,0x3e8
L_8d7e1c:
	mov_s r0,0x17eac
L_8d7e22:
	mov_s r1,r13
L_8d7e24:
	mov_s r2,0x0
L_8d7e26:
	mov r4,mlo
L_8d7e2a:
	mov_s r3,0x0
L_8d7e2c:
	mov r5,0x0
L_8d7e30:
	bl.d L_8dc92c
L_8d7e34:
	mov r6,0x0
L_8d7e38:
	st_s r0,[r13,0x18]
L_8d7e3a:
	ldb_s r3,[r13,0x10]
L_8d7e3c:
	mov_s r2,0x1013f40
L_8d7e42:
	mov_s r0,0xc
L_8d7e44:
	mov_s r1,0x2
L_8d7e46:
	bl.d L_8edff8
L_8d7e4a:
	mov_s r4,r14
	.global L_8d7e4c
L_8d7e4c:
	b L_8c0334
