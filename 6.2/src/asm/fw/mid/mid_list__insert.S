/* mid_list__insert @ 0x8e5f0c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_started_log
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal, list__find_entry_d, mid_list__by_mid_fw
 * Глобалы (через gp): 0x800259
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid_list__insert
mid_list__insert:
	.global L_8e5f0c
L_8e5f0c:
	push_s blink
L_8e5f0e:
	push_s r13
L_8e5f10:
	mov_s r13,r0
L_8e5f12:
	bl.d L_8cc3dc
L_8e5f16:
	ldb_s r0,[r0,0x10]
L_8e5f18:
	brne_s r0,0,L_8e5f36
	.global L_8e5f1a
L_8e5f1a:
	mov_s r0,0x804e70
L_8e5f20:
	bl.d L_8c25f4
L_8e5f24:
	mov_s r1,r13
L_8e5f26:
	ldb_s r1,[r13,0x10]
L_8e5f28:
	ldb_s r0,[gp,0xd5]
L_8e5f2a:
	bset r0,r0,r1
L_8e5f2e:
	b.d L_8c025c
L_8e5f32:
	stb r0,[gp, 0xd5]
	.global L_8e5f36
L_8e5f36:
	mov_s r0,blink
L_8e5f38:
	mov_s r1,0x11c4
L_8e5f3e:
	bl L_8c9b28
L_8e5f42:
	b_s L_8e5f1a
