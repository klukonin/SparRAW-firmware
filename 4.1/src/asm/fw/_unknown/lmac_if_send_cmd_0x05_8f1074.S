/* lmac_if_send_cmd_0x05_8f1074 @ 0x8f1074, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__teardown_mac_rules, conn_msm__on_own_start_link__unresourced
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, lmac_mbox__alloc_slot, send_cmd2_lmac
 */
	.section .text.lmac_if_send_cmd_0x05_8f1074,"ax",@progbits
	.global lmac_if_send_cmd_0x05_8f1074
lmac_if_send_cmd_0x05_8f1074:
	.global L_8f1074
L_8f1074:
	push_s blink
L_8f1076:
	bl L_8c02c4
L_8f107a:
	mov_s r13,r0
L_8f107c:
	bl.d L_8c2b0c
L_8f1080:
	mov_s r14,r1
L_8f1082:
	st_s r14,[r0,0xc]
L_8f1084:
	ldb_s r1,[r13,0x8]
L_8f1086:
	add2 r3,r13,0x19
L_8f108a:
	stb_s r1,[r0,0x8]
L_8f108c:
	ldb_s r1,[r3,0x12]
L_8f108e:
	mov_s r2,0x803e84
L_8f1094:
	stw_s r1,[r0,0x2]
L_8f1096:
	ldb_s r1,[r2]
L_8f1098:
	stb_s r1,[r0]
L_8f109a:
	ldb_s r1,[r3,0x11]
L_8f109c:
	stw_s r1,[r0,0x6]
L_8f109e:
	ldb_s r1,[r2]
L_8f10a0:
	add r3,r0,0x20
L_8f10a4:
	stb_s r1,[r0,0x4]
L_8f10a6:
	mov_s r1,0x0
L_8f10a8:
	stw_s r1,[r0,0xa]
L_8f10aa:
	mov_s r2,0x80345c
L_8f10b0:
	ld_s r1,[r2,0xc]
L_8f10b2:
	stb_s r1,[r3]
L_8f10b4:
	ld_s r1,[r2,0xc]
L_8f10b6:
	brne r1,0x1,L_8f10c2
L_8f10ba:
	ldb_s r1,[r2,0x10]
L_8f10bc:
	stb_s r1,[r3,0x1]
L_8f10be:
	ldb_s r1,[r2,0x11]
L_8f10c0:
	stb_s r1,[r3,0x2]
	.global L_8f10c2
L_8f10c2:
	ld_s r1,[r13,0x10]
L_8f10c4:
	mov_s r2,0x24
L_8f10c6:
	st_s r1,[r0,0x18]
L_8f10c8:
	ldw_s r1,[r13,0x14]
L_8f10ca:
	stw_s r1,[r0,0x1c]
L_8f10cc:
	mov_s r1,0x5
L_8f10ce:
	bl.d L_8e0694
L_8f10d2:
	mov_s r3,0x0
L_8f10d4:
	b L_8c0334
