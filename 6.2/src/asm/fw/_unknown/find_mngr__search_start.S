/* find_mngr__search_start @ 0x8e4b28, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND:: Search for %d msec.
 *   FIND:: Start SEARCHING on channel %d for %d msec.
 * Зовут его: find_mng__search
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_log_emit1, lmac_if_discovery_mode_cfg_handler, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_mngr__search_start
find_mngr__search_start:
	.global L_8e4b28
L_8e4b28:
	push_s blink
L_8e4b2a:
	bl L_8c01e4
L_8e4b2e:
	mov_s r14,r0
L_8e4b30:
	mov_s r13,r1
L_8e4b32:
	mov_s r0,0x1
L_8e4b34:
	bl.d L_8db724
L_8e4b38:
	mov_s r1,r0
L_8e4b3a:
	add r0,r14,0x1c
L_8e4b3e:
	mov_s r1,0x1
L_8e4b40:
	mov_s r2,0x0
L_8e4b42:
	mov_s r3,r2
L_8e4b44:
	bl.d L_8d9b6c
L_8e4b48:
	mov_s r4,r2
L_8e4b4a:
	mov_s r1,0x10179c4
L_8e4b50:
	mov_s r0,0x2c
L_8e4b52:
	bl.d L_8dcc10
L_8e4b56:
	mov_s r2,r13
L_8e4b58:
	breq_s r13,0,L_8e4b86
L_8e4b5a:
	mul64 r13,0x3e8
L_8e4b5e:
	mov_s r2,0x0
L_8e4b60:
	mov_s r0,L_8e4ca0-0x8c0000
L_8e4b66:
	mov_s r1,r14
L_8e4b68:
	mov r4,mlo
L_8e4b6c:
	mov_s r3,r2
L_8e4b6e:
	mov_s r5,r2
L_8e4b70:
	bl.d L_8e0c0c
L_8e4b74:
	mov_s r6,r2
L_8e4b76:
	st_s r0,[r14,0x18]
L_8e4b78:
	mov_s r1,0x10179e0
L_8e4b7e:
	mov_s r0,0x2c
L_8e4b80:
	bl.d L_8dcc10
L_8e4b84:
	mov_s r2,r13
	.global L_8e4b86
L_8e4b86:
	b L_8c0254
L_8e4b8a:
	nop_s
