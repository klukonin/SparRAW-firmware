/* find_mngr__listen_start @ 0x8daf40, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND:: Listen for %d msec.
 *   FIND:: Start LISTENING on channel %d for %d msec.
 * Зовут его: find_mng__listen
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_log_emit1, fw_log_emit2, lmac_if_discovery_mode_cfg_handler, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_mngr__listen_start
find_mngr__listen_start:
	.global L_8daf40
L_8daf40:
	push_s blink
L_8daf42:
	bl L_8c01e4
L_8daf46:
	mov_s r14,r0
L_8daf48:
	mov_s r13,r1
L_8daf4a:
	mov_s r0,0x1
L_8daf4c:
	bl.d L_8db724
L_8daf50:
	mov_s r1,0x0
L_8daf52:
	add r0,r14,0x1c
L_8daf56:
	mov_s r1,0x0
L_8daf58:
	mov_s r2,r1
L_8daf5a:
	mov_s r3,r1
L_8daf5c:
	bl.d L_8d9b6c
L_8daf60:
	mov_s r4,r1
L_8daf62:
	mov_s r1,0x1017974
L_8daf68:
	mov_s r0,0x2c
L_8daf6a:
	bl.d L_8dcc10
L_8daf6e:
	mov_s r2,r13
L_8daf70:
	breq_s r13,0,L_8dafa4
L_8daf72:
	mul64 r13,0x3e8
L_8daf76:
	mov_s r0,L_8db004-0x8c0000
L_8daf7c:
	mov_s r1,r14
L_8daf7e:
	mov_s r2,0x0
L_8daf80:
	mov r4,mlo
L_8daf84:
	mov_s r3,0x0
L_8daf86:
	mov r5,0x0
L_8daf8a:
	bl.d L_8e0c0c
L_8daf8e:
	mov r6,0x0
L_8daf92:
	st_s r0,[r14,0x18]
L_8daf94:
	ldb_s r2,[r14,0x10]
L_8daf96:
	mov_s r1,0x1017990
L_8daf9c:
	mov_s r0,0x2c
L_8daf9e:
	bl.d L_8dcc80
L_8dafa2:
	mov_s r3,r13
	.global L_8dafa4
L_8dafa4:
	b L_8c0254
