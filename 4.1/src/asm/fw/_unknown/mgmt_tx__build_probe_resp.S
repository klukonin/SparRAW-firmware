/* mgmt_tx__build_probe_resp @ 0x8f1f50, 292 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PROBE RESP header %d bytes, so far %d bytes, pkt at 0x%8X
 *   PROBE RESP fields %d bytes, so far %d bytes, pkt at 0x%8X
 *   PROBE RESP no external APP IEs are built
 *   PROBE RESP internal IEs %d len
 *   Build serv: Probe Resp 60GHz Capability length %d total %d
 * Зовут его: find_main_sm__probe_req, find_main_sm__probe_req_in_search, tx_probe__send_probe_resp
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, app_ies__set_buffer, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_log__emit3, ie__push_wfa_vendor, ies_block__is_empty, ies_block__merge, log_hexdump, mgmt_tx__append_probe_resp_ies
 */
	.section .text.mgmt_tx__build_probe_resp,"ax",@progbits
	.global mgmt_tx__build_probe_resp
mgmt_tx__build_probe_resp:
	.global L_8f1f50
L_8f1f50:
	push_s blink
L_8f1f52:
	bl L_8c02a4
L_8f1f56:
	sub sp,sp,0x110
L_8f1f5a:
	mov_s r14,r0
L_8f1f5c:
	mov_s r16,r1
L_8f1f5e:
	mov_s r17,r2
L_8f1f60:
	mov_s r19,r3
L_8f1f62:
	mov r18,r4
L_8f1f66:
	st_s r0,[sp,0x0]
L_8f1f68:
	add_s r3,r3,0x10
L_8f1f6a:
	mov_s r0,r2
L_8f1f6c:
	mov_s r1,r14
L_8f1f6e:
	bl.d L_8ec5c0
L_8f1f72:
	mov_s r2,0x5
L_8f1f74:
	mov_s r2,0x1010780
L_8f1f7a:
	ld r5,[sp]
L_8f1f7e:
	mov_s r0,0xd
L_8f1f80:
	mov_s r1,0x2
L_8f1f82:
	mov_s r3,0x18
L_8f1f84:
	bl.d L_8ee034
L_8f1f88:
	mov r4,0x0
L_8f1f8c:
	ld_s r0,[sp,0x0]
L_8f1f8e:
	add3 r13,r17,0x9
L_8f1f92:
	add_s r0,r0,0x18
L_8f1f94:
	st_s r0,[sp,0x0]
L_8f1f96:
	bl.d L_8eca84
L_8f1f9a:
	mov_s r1,r13
L_8f1f9c:
	mov_s r15,r0
L_8f1f9e:
	mov_s r2,0x10107bc
L_8f1fa4:
	ld r5,[sp]
L_8f1fa8:
	mov_s r0,0xd
L_8f1faa:
	mov_s r1,0x2
L_8f1fac:
	mov_s r3,r15
L_8f1fae:
	bl.d L_8ee034
L_8f1fb2:
	mov r4,0x18
L_8f1fb6:
	ld_s r0,[sp,0x0]
L_8f1fb8:
	add r20,r15,0x18
L_8f1fbc:
	add_s r0,r0,r15
L_8f1fbe:
	st_s r0,[sp,0x0]
L_8f1fc0:
	mov_s r0,r13
L_8f1fc2:
	bl.d L_8c97fc
L_8f1fc6:
	mov_s r1,0x5
L_8f1fc8:
	mov_s r21,r0
L_8f1fca:
	ld.as r0,[r19,0x60]
L_8f1fce:
	mov_s r15,0x1
L_8f1fd0:
	cmp_s r0,0x0
L_8f1fd2:
	sub_s.ne r15,r15,r15
L_8f1fd4:
	bl.d L_8d70f0
L_8f1fd8:
	mov_s r0,r21
L_8f1fda:
	extw r20,r20
L_8f1fde:
	breq_s r0,0,L_8f1ffa
L_8f1fe0:
	mov_s r2,0x10107f8
L_8f1fe6:
	mov_s r0,0xd
L_8f1fe8:
	bl.d L_8edfb0
L_8f1fec:
	mov_s r1,0x2
L_8f1fee:
	ld_s r0,[sp,0x0]
L_8f1ff0:
	mov_s r1,r13
L_8f1ff2:
	bl.d L_8ecaec
L_8f1ff6:
	mov_s r2,r15
L_8f1ff8:
	b_s L_8f2032
	.global L_8f1ffa
L_8f1ffa:
	add_s r0,sp,0x4
L_8f1ffc:
	mov_s r19,r0
L_8f1ffe:
	mov_s r1,r13
L_8f2000:
	bl.d L_8ecaec
L_8f2004:
	mov_s r2,r15
L_8f2006:
	mov_s r22,r0
L_8f2008:
	mov_s r2,0x1010824
L_8f200e:
	mov_s r0,0xd
L_8f2010:
	mov_s r1,0x2
L_8f2012:
	bl.d L_8edfcc
L_8f2016:
	mov_s r3,r22
L_8f2018:
	add3 r13,sp,0x20
L_8f201c:
	add_s r0,r13,0x4
L_8f201e:
	mov_s r1,r19
L_8f2020:
	mov_s r2,r22
L_8f2022:
	bl.d L_8e1afc
L_8f2026:
	mov_s r3,r18
L_8f2028:
	mov_s r0,sp
L_8f202a:
	mov_s r1,r21
L_8f202c:
	bl.d L_8da098
L_8f2030:
	add_s r2,r13,0x4
	.global L_8f2032
L_8f2032:
	add r13,r20,r0
L_8f2036:
	extw_s r13,r13
L_8f2038:
	add r1,r17,0xa
L_8f203c:
	ld_s r0,[sp,0x0]
L_8f203e:
	bl.d L_8ef740
L_8f2042:
	mov_s r2,0x0
L_8f2044:
	extw_s r3,r0
L_8f2046:
	add r17,r13,r3
L_8f204a:
	extw r17,r17
L_8f204e:
	mov_s r2,0x1010844
L_8f2054:
	mov_s r0,0xd
L_8f2056:
	mov_s r1,0x2
L_8f2058:
	bl.d L_8edff8
L_8f205c:
	mov r4,r17
L_8f2060:
	mov_s r0,r14
L_8f2062:
	bl.d L_8c7f90
L_8f2066:
	mov_s r1,r17
L_8f2068:
	st r17,[r16]
L_8f206c:
	b.d L_8c02f4
L_8f2070:
	add sp,sp,0x110
