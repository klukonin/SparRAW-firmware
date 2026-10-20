/* conn_main_sm__linkup_ntf @ 0x8daddc, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_main_sm::linkup_ntf() status=%d, CID=%d.
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit2, lmac_if__send_cmd_04_thunk, maintain_ctx__set_field_9c, sm__defer_call, u_schd__add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_main_sm__linkup_ntf
conn_main_sm__linkup_ntf:
	.global L_8daddc
L_8daddc:
	push_s blink
L_8dadde:
	bl L_8c01e0
L_8dade2:
	mov_s r14,r0
L_8dade4:
	mov_s r15,r1
L_8dade6:
	mov_s r1,0x1011a30
L_8dadec:
	ld_s r3,[r0,0x8]
L_8dadee:
	mov_s r0,0x2b
L_8dadf0:
	mov_s r2,r15
L_8dadf2:
	bl.d L_8dcc80
L_8dadf6:
	ldb_s r3,[r3,0x8]
L_8dadf8:
	mov_s r13,0x0
L_8dadfa:
	st_s r13,[r14,0x38]
L_8dadfc:
	st_s r13,[r14,0x34]
L_8dadfe:
	bl.d L_8db718
L_8dae02:
	mov_s r0,0x1
L_8dae04:
	ld_s r0,[r14,0x8]
L_8dae06:
	add_s r0,r0,0x70
L_8dae08:
	bl.d L_8ea9c8
L_8dae0c:
	mov_s r1,r13
L_8dae0e:
	ld_s r0,[r14,0x8]
L_8dae10:
	brne_s r15,0,L_8dae2e
L_8dae12:
	ld_s r0,[r0,0x24]
L_8dae14:
	cmp_s r0,0x1
L_8dae16:
	mov.eq r0,r14
L_8dae1a:
	mov.eq r1,0x3
L_8dae1e:
	mov.eq r2,r13
L_8dae22:
	mov.eq r3,r13
L_8dae26:
	bl.eq.d L_8e7044
L_8dae2a:
	mov.eq r4,r13
	.global L_8dae2e
L_8dae2e:
	mov_s r0,0x35e0c
L_8dae34:
	ld_s r1,[r14,0x8]
L_8dae36:
	mov_s r2,r15
L_8dae38:
	bl.d L_8c3248
L_8dae3c:
	mov_s r3,0x1
L_8dae3e:
	b L_8c024c
L_8dae42:
	nop_s
