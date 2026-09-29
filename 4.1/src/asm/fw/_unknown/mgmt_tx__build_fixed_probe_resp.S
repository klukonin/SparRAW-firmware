/* mgmt_tx__build_fixed_probe_resp @ 0x8e4d0c, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIXED SW PROBE RESP header %d bytes, so far %d bytes, pkt at 0x%8X
 *   PROBE RESP fields %d bytes, so far %d bytes, pkt at 0x%8X
 * Зовут его: mgmt_tx__render_probe_resp
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit3, log_hexdump, memcpy_fw, mgmt_tx__probe_resp_ies, mgmt_tx__probe_resp_tsf_bi_ie
 */
	.section .text.mgmt_tx__build_fixed_probe_resp,"ax",@progbits
	.global mgmt_tx__build_fixed_probe_resp
mgmt_tx__build_fixed_probe_resp:
	.global L_8e4d0c
L_8e4d0c:
	push_s blink
L_8e4d0e:
	bl L_8c02b0
L_8e4d12:
	mov_s r13,r0
L_8e4d14:
	mov_s r16,r1
L_8e4d16:
	mov_s r14,r2
L_8e4d18:
	mov_s r15,r3
L_8e4d1a:
	mov r17,r4
L_8e4d1e:
	mov_s r1,r3
L_8e4d20:
	bl.d L_8c0460
L_8e4d24:
	mov_s r2,0x18
L_8e4d26:
	add r18,r13,0x18
L_8e4d2a:
	add_s r15,r15,0x24
L_8e4d2c:
	sub r19,r17,0x24
L_8e4d30:
	extw r19,r19
L_8e4d34:
	mov_s r2,0x1010880
L_8e4d3a:
	mov_s r0,0xd
L_8e4d3c:
	mov_s r1,0x2
L_8e4d3e:
	mov_s r3,0x18
L_8e4d40:
	mov_s r4,r3
L_8e4d42:
	bl.d L_8ee034
L_8e4d46:
	mov r5,r18
L_8e4d4a:
	add3 r1,r14,0x9
L_8e4d4e:
	bl.d L_8eca84
L_8e4d52:
	mov_s r0,r18
L_8e4d54:
	mov_s r3,r0
L_8e4d56:
	add r18,r18,r0
L_8e4d5a:
	add r17,r0,0x18
L_8e4d5e:
	extw r17,r17
L_8e4d62:
	mov_s r2,0x10107bc
L_8e4d68:
	mov_s r0,0xd
L_8e4d6a:
	mov_s r1,0x2
L_8e4d6c:
	mov r4,r17
L_8e4d70:
	bl.d L_8ee034
L_8e4d74:
	mov r5,r18
L_8e4d78:
	mov_s r0,r18
L_8e4d7a:
	mov_s r1,r14
L_8e4d7c:
	mov_s r2,r15
L_8e4d7e:
	bl.d L_8ecd10
L_8e4d82:
	mov_s r3,r19
L_8e4d84:
	add r13,r0,r17
L_8e4d88:
	extw_s r13,r13
L_8e4d8a:
	mov_s r0,r18
L_8e4d8c:
	bl.d L_8c7f90
L_8e4d90:
	mov_s r1,r13
L_8e4d92:
	b.d L_8c030c
L_8e4d96:
	stw r13,[r16]
L_8e4d9a:
	nop_s
