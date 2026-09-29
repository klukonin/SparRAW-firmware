/* mid__replace_rsn_ie @ 0x8e1fe8, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Replace RSN IE 0x%x new ie_len %d
 *   mid.cpp
 * Зовут его: mid__apply_app_ies
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit2, fw_sysassert_fatal, log_hexdump, memcpy_fw
 */
	.section .text.mid__replace_rsn_ie,"ax",@progbits
	.global mid__replace_rsn_ie
mid__replace_rsn_ie:
	.global L_8e1fe8
L_8e1fe8:
	push_s blink
L_8e1fea:
	bl L_8c02b8
L_8e1fee:
	mov_s r17,r0
L_8e1ff0:
	ldb_s r0,[r1,0x1]
L_8e1ff2:
	mov_s r13,r1
L_8e1ff4:
	add r16,r0,0x2
L_8e1ff8:
	mov_s r0,r1
L_8e1ffa:
	bl.d L_8c7f90
L_8e1ffe:
	mov_s r1,r16
L_8e2000:
	ldb_s r3,[r13]
L_8e2002:
	mov_s r2,0x100b1b0
L_8e2008:
	mov_s r0,0xb
L_8e200a:
	mov_s r1,0x2
L_8e200c:
	bl.d L_8edff8
L_8e2010:
	mov r4,r16
L_8e2014:
	brhs r16,0x29,L_8e2032
	.global L_8e2018
L_8e2018:
	add r17,r17,0x180
L_8e201c:
	mov_s r0,r17
L_8e201e:
	mov_s r1,r13
L_8e2020:
	bl.d L_8c0460
L_8e2024:
	mov_s r2,r16
L_8e2026:
	mov_s r0,r17
L_8e2028:
	bl.d L_8c7f90
L_8e202c:
	mov_s r1,r16
L_8e202e:
	b L_8c031c
	.global L_8e2032
L_8e2032:
	mov_s r0,blink
L_8e2034:
	mov_s r2,0x100aedc
L_8e203a:
	mov_s r1,0x1482
L_8e2040:
	bl.d L_8c82c0
L_8e2044:
	mov r3,0x2c8
L_8e2048:
	b_s L_8e2018
L_8e204a:
	nop_s
