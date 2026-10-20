/* pbss__alloc_sta_entry @ 0x8e0148, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pbss__add_sta
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, conn_mgr__activate_conn, conn_mgr__alloc_cid, connection__init, fw_sysassert_fatal, list__find_entry_d
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pbss__alloc_sta_entry
pbss__alloc_sta_entry:
	.global L_8e0148
L_8e0148:
	push_s blink
L_8e014a:
	bl L_8c01dc
L_8e014e:
	mov_s r13,r0
L_8e0150:
	mov_s r16,r1
L_8e0152:
	bl.d L_8c3290
L_8e0156:
	mov_s r15,r2
L_8e0158:
	mov.f r14,r0
L_8e015c:
	beq_s L_8e0196
	.global L_8e015e
L_8e015e:
	mov_s r0,r14
L_8e0160:
	mov_s r1,r16
L_8e0162:
	bl.d L_8f54a4
L_8e0166:
	mov_s r2,r13
L_8e0168:
	stb_s r15,[r14,0x9]
L_8e016a:
	mov_s r15,0x1
L_8e016c:
	st_s r15,[r14,0x28]
L_8e016e:
	st_s r15,[r14,0x24]
L_8e0170:
	mov_s r0,0x0
L_8e0172:
	st_s r0,[r14,0x2c]
L_8e0174:
	add r0,r13,0x18
L_8e0178:
	bl.d L_8c25f4
L_8e017c:
	mov_s r1,r14
L_8e017e:
	mov_s r0,r14
L_8e0180:
	bl.d L_8c2460
L_8e0184:
	mov_s r1,r15
L_8e0186:
	ldb r1,[r13, 0x24]
L_8e018a:
	bset r1,r1,r0
L_8e018e:
	b.d L_8c0244
L_8e0192:
	stb r1,[r13, 0x24]
	.global L_8e0196
L_8e0196:
	mov_s r0,blink
L_8e0198:
	mov_s r1,0x16cb
L_8e019e:
	bl L_8c9b28
L_8e01a2:
	b_s L_8e015e
