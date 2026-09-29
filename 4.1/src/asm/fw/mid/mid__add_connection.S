/* mid__add_connection @ 0x8dc03c, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mid.cpp
 * Зовут его: pbss__add_sta
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, conn_mgr__activate_conn, conn_mgr__alloc_cid, connection__init, fw_sysassert_fatal, llist__insert
 */
	.section .text.mid__add_connection,"ax",@progbits
	.global mid__add_connection
mid__add_connection:
	.global L_8dc03c
L_8dc03c:
	push_s blink
L_8dc03e:
	bl L_8c02bc
L_8dc042:
	mov_s r13,r0
L_8dc044:
	mov_s r16,r1
L_8dc046:
	bl.d L_8c2b18
L_8dc04a:
	mov_s r15,r2
L_8dc04c:
	mov.f r14,r0
L_8dc050:
	beq_s L_8dc08a
	.global L_8dc052
L_8dc052:
	mov_s r0,r14
L_8dc054:
	mov_s r1,r16
L_8dc056:
	bl.d L_8ed290
L_8dc05a:
	mov_s r2,r13
L_8dc05c:
	stb_s r15,[r14,0x9]
L_8dc05e:
	mov_s r15,0x1
L_8dc060:
	st_s r15,[r14,0x1c]
L_8dc062:
	st_s r15,[r14,0x18]
L_8dc064:
	mov_s r0,0x0
L_8dc066:
	st_s r0,[r14,0x20]
L_8dc068:
	add r0,r13,0x18
L_8dc06c:
	bl.d L_8c1fc4
L_8dc070:
	mov_s r1,r14
L_8dc072:
	mov_s r0,r14
L_8dc074:
	bl.d L_8c1df0
L_8dc078:
	mov_s r1,r15
L_8dc07a:
	ldb r1,[r13, 0x24]
L_8dc07e:
	bset r1,r1,r0
L_8dc082:
	b.d L_8c0324
L_8dc086:
	stb r1,[r13, 0x24]
	.global L_8dc08a
L_8dc08a:
	mov_s r0,blink
L_8dc08c:
	mov_s r2,0x100aedc
L_8dc092:
	mov_s r1,0x146c
L_8dc098:
	bl.d L_8c82c0
L_8dc09c:
	mov_s r3,0x7d
L_8dc09e:
	b_s L_8dc052
