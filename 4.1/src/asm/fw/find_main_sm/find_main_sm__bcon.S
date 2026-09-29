/* find_main_sm__bcon @ 0x8e9d48, 228 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   find_main_sm::bcon()
 *   FIND_SM:: dband info pool is empty !!!! %x
 *   find_main_sm.cpp
 *   FIND_SM:: DMG Beacon info added: ADDR-%04X%08X
 * Зовут его: find_sm__dband_bcon_in_search
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, alloc_dband_info, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_read_timer, fw_sysassert_fatal, llist__insert, log_hexdump, memcpy_fw, mid__acquire_link
 */
	.section .text.find_main_sm__bcon,"ax",@progbits
	.global find_main_sm__bcon
find_main_sm__bcon:
	.global L_8e9d48
L_8e9d48:
	push_s blink
L_8e9d4a:
	bl L_8c02b8
L_8e9d4e:
	mov_s r16,r0
L_8e9d50:
	ld_s r15,[r1,0x8]
L_8e9d52:
	mov_s r13,r1
L_8e9d54:
	/* add_s r15,0x4 */
	.byte 0x04,0xe7
L_8e9d56:
	mov_s r2,0x1014748
L_8e9d5c:
	mov_s r0,0xc
L_8e9d5e:
	bl.d L_8edfb0
L_8e9d62:
	mov_s r1,0x2
L_8e9d64:
	add r17,r16,0x3c
L_8e9d68:
	mov_s r0,r17
L_8e9d6a:
	bl.d L_8f020c
L_8e9d6e:
	mov_s r1,r15
L_8e9d70:
	brne_s r0,0,L_8e9d9c
	.global L_8e9d72
L_8e9d72:
	mov_s r0,0x843134
L_8e9d78:
	ld_s r1,[r0,0xc]
L_8e9d7a:
	ld_s r0,[r0,0x10]
L_8e9d7c:
	cmp_s r1,r0
L_8e9d7e:
	mov_s r0,0x1
L_8e9d80:
	sub.cs r0,r0,r0
L_8e9d84:
	breq_s r0,0,L_8e9db0
L_8e9d86:
	bl L_8e4694
L_8e9d8a:
	mov_s r2,0x1014760
L_8e9d90:
	mov_s r3,r0
L_8e9d92:
	mov_s r0,0xc
L_8e9d94:
	bl.d L_8edfcc
L_8e9d98:
	mov_s r1,0x1
L_8e9d9a:
	b_s L_8e9e16
	.global L_8e9d9c
L_8e9d9c:
	mov_s r0,blink
L_8e9d9e:
	mov_s r2,0x101478c
L_8e9da4:
	mov_s r1,0x35
L_8e9da6:
	bset_s r1,r1,0xc
L_8e9da8:
	bl.d L_8c82c0
L_8e9dac:
	mov_s r3,0xf5
L_8e9dae:
	b_s L_8e9d72
	.global L_8e9db0
L_8e9db0:
	bl L_8e94a4
L_8e9db4:
	mov.f r14,r0
L_8e9db8:
	beq_s L_8e9e1a
	.global L_8e9dba
L_8e9dba:
	mov_s r2,0x10147a0
L_8e9dc0:
	ld r4,[r15]
L_8e9dc4:
	mov_s r0,0x9
L_8e9dc6:
	mov_s r1,0x2
L_8e9dc8:
	bl.d L_8edff8
L_8e9dcc:
	ldw_s r3,[r15,0x4]
L_8e9dce:
	ld_s r0,[r13,0x8]
L_8e9dd0:
	bl.d L_8c7f90
L_8e9dd4:
	ld_s r1,[r13,0x30]
L_8e9dd6:
	add r0,r14,0x8
L_8e9dda:
	mov_s r1,r15
L_8e9ddc:
	bl.d L_8c0460
L_8e9de0:
	mov_s r2,0x6
L_8e9de2:
	ld_s r1,[r13,0xc]
L_8e9de4:
	breq_s r1,0,L_8e9dfe
L_8e9de6:
	ldb_s r2,[r1,0x9]
L_8e9de8:
	brlt r2,0x1,L_8e9dfe
L_8e9dec:
	add r0,r14,0x10
L_8e9df0:
	bl.d L_8c0460
L_8e9df4:
	ld_s r1,[r1,0xc]
L_8e9df6:
	ld_s r0,[r13,0xc]
L_8e9df8:
	ldb_s r0,[r0,0x9]
L_8e9dfa:
	stb r0,[r14, 0x30]
	.global L_8e9dfe
L_8e9dfe:
	ld r0,[r16, 0x34]
L_8e9e02:
	mov_s r1,r15
L_8e9e04:
	ld_s r0,[r0,0x6c]
L_8e9e06:
	mov_s r2,0x0
L_8e9e08:
	bl.d L_8d7814
L_8e9e0c:
	mov_s r3,r2
L_8e9e0e:
	mov_s r0,r17
L_8e9e10:
	bl.d L_8c1fc4
L_8e9e14:
	mov_s r1,r14
	.global L_8e9e16
L_8e9e16:
	b L_8c031c
	.global L_8e9e1a
L_8e9e1a:
	mov_s r0,blink
L_8e9e1c:
	mov_s r2,0x101478c
L_8e9e22:
	mov_s r1,0x4
L_8e9e24:
	bset_s r1,r1,0xc
L_8e9e26:
	bl.d L_8c82c0
L_8e9e2a:
	mov_s r3,0xfd
