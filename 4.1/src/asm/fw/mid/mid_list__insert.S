/* mid_list__insert @ 0x8e1248, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mid.cpp
 * Зовут его: l2mgr__mac_started_log
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal, llist__insert, mid_list__by_mid
 * Глобалы (через gp): 0x800242
 */
	.section .text.mid_list__insert,"ax",@progbits
	.global mid_list__insert
mid_list__insert:
	.global L_8e1248
L_8e1248:
	push_s blink
L_8e124a:
	push_s r13
L_8e124c:
	mov_s r13,r0
L_8e124e:
	bl.d L_8ca1b0
L_8e1252:
	ldb_s r0,[r0,0x10]
L_8e1254:
	brne_s r0,0,L_8e1272
	.global L_8e1256
L_8e1256:
	mov_s r0,0x8058d0
L_8e125c:
	bl.d L_8c1fc4
L_8e1260:
	mov_s r1,r13
L_8e1262:
	ldb_s r1,[r13,0x10]
L_8e1264:
	ldb_s r0,[gp,0xd2]
L_8e1266:
	bset r0,r0,r1
L_8e126a:
	b.d L_8c033c
L_8e126e:
	stb r0,[gp, 0xd2]
	.global L_8e1272
L_8e1272:
	mov_s r0,blink
L_8e1274:
	mov_s r2,0x100aedc
L_8e127a:
	mov_s r1,0x11c4
L_8e1280:
	bl.d L_8c82c0
L_8e1284:
	mov_s r3,0x9c
L_8e1286:
	b_s L_8e1256
