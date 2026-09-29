/* log_hexdump @ 0x8c7f90, 300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *       %02x
 *       %02x%02x
 *       %02x%02x%02x
 *       %08x
 *       %08x:%02x
 *       %08x%02x:%02x
 *       %08x%04x%02x
 *       %08x:%08x
 * Зовут его: SW_TX_MGMT_API__send_packet, app_ie__print_ies, find_main_sm__bcon, ieee80211_mgt_information_response_construct, l2mgr__install_key, l2mgr__send_keys_to_ucode, mgmt_tx__build_assoc_req, mgmt_tx__build_assoc_resp, mgmt_tx__build_fixed_probe_resp, mgmt_tx__build_probe_req
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit1, fw_log__emit2, fw_log__emit3
 */
	.section .text.log_hexdump,"ax",@progbits
	.global log_hexdump
log_hexdump:
	.global L_8c7f90
L_8c7f90:
	push_s blink
L_8c7f92:
	bl L_8c02b8
L_8c7f96:
	mov_s r14,r0
L_8c7f98:
	mov_s r16,r1
L_8c7f9a:
	mov_s r13,r1
L_8c7f9c:
	mov r17,0x0
L_8c7fa0:
	b_s L_8c7faa
	.global L_8c7fa2
L_8c7fa2:
	add r17,r17,0xc
L_8c7fa6:
	sub_s r13,r13,0xc
L_8c7fa8:
	add_s r14,r14,0xc
	.global L_8c7faa
L_8c7faa:
	cmp r16,r17
L_8c7fae:
	bls L_8c80b8
L_8c7fb2:
	sub_s r1,r13,0x1
L_8c7fb4:
	cmp_s r1,0xb
L_8c7fb6:
	bhi.d L_8c809a
L_8c7fba:
	mov_s r15,0x2
L_8c7fbc:
	ldb.x r1,[0x80187c,r1]
L_8c7fc4:
	add r0,pcl,0x8
L_8c7fc8:
	add1_s r0,r0,r1
L_8c7fca:
	j_s [r0]
L_8c7fcc:
	mov_s r2,0x1000bcc
L_8c7fd2:
	mov_s r0,0x0
L_8c7fd4:
	mov_s r1,r15
L_8c7fd6:
	bl.d L_8edfcc
L_8c7fda:
	ldb_s r3,[r14]
L_8c7fdc:
	mov_s r13,0x1
L_8c7fde:
	b_s L_8c80b2
L_8c7fe0:
	mov_s r2,0x1000bd8
L_8c7fe6:
	ldb r4,[r14, 0x1]
L_8c7fea:
	mov_s r0,0x0
L_8c7fec:
	mov_s r1,r15
L_8c7fee:
	bl.d L_8edff8
L_8c7ff2:
	ldb_s r3,[r14]
L_8c7ff4:
	mov_s r13,r15
L_8c7ff6:
	b_s L_8c80b2
L_8c7ff8:
	ldb_s r3,[r14]
L_8c7ffa:
	mov_s r13,0x3
L_8c7ffc:
	ldb r4,[r14, 0x1]
L_8c8000:
	mov_s r2,0x1000be8
L_8c8006:
	ldb r5,[r14, 0x2]
L_8c800a:
	b_s L_8c8094
L_8c800c:
	mov_s r2,0x1000bfc
L_8c8012:
	mov_s r0,0x0
L_8c8014:
	mov_s r1,r15
L_8c8016:
	bl.d L_8edfcc
L_8c801a:
	ld_s r3,[r14]
L_8c801c:
	mov_s r13,0x4
L_8c801e:
	b_s L_8c80b2
L_8c8020:
	ldb r4,[r14, 0x4]
L_8c8024:
	mov_s r13,0x5
L_8c8026:
	mov_s r2,0x1000c08
	.global L_8c802c
L_8c802c:
	mov_s r0,0x0
L_8c802e:
	mov_s r1,r15
L_8c8030:
	bl.d L_8edff8
L_8c8034:
	ld_s r3,[r14]
L_8c8036:
	b_s L_8c80b2
L_8c8038:
	ld_s r3,[r14]
L_8c803a:
	mov_s r13,0x6
L_8c803c:
	ldb r4,[r14, 0x4]
L_8c8040:
	mov_s r2,0x1000c18
L_8c8046:
	ldb r5,[r14, 0x5]
L_8c804a:
	b_s L_8c8094
L_8c804c:
	ld_s r3,[r14]
L_8c804e:
	mov_s r13,0x7
L_8c8050:
	ldw r4,[r14, 0x4]
L_8c8054:
	mov_s r2,0x1000c2c
L_8c805a:
	ldb r5,[r14, 0x6]
L_8c805e:
	b_s L_8c8094
L_8c8060:
	mov_s r13,0x8
L_8c8062:
	mov_s r2,0x1000c40
L_8c8068:
	ld r4,[r14, 0x4]
L_8c806c:
	b_s L_8c802c
L_8c806e:
	ld_s r3,[r14]
L_8c8070:
	mov_s r13,0x9
L_8c8072:
	ld r4,[r14, 0x4]
L_8c8076:
	mov_s r2,0x1000c50
L_8c807c:
	ldb r5,[r14, 0x8]
L_8c8080:
	b_s L_8c8094
L_8c8082:
	ldw_s r3,[r14]
L_8c8084:
	mov_s r13,0xa
L_8c8086:
	ld r4,[r14, 0x4]
L_8c808a:
	mov_s r2,0x1000c64
L_8c8090:
	ldw r5,[r14, 0x8]
	.global L_8c8094
L_8c8094:
	mov_s r0,0x0
L_8c8096:
	mov_s r1,r15
L_8c8098:
	b_s L_8c80ae
	.global L_8c809a
L_8c809a:
	ld_s r3,[r14]
L_8c809c:
	mov_s r2,0x1000c78
L_8c80a2:
	ld r4,[r14, 0x4]
L_8c80a6:
	mov_s r0,0x0
L_8c80a8:
	ld r5,[r14, 0x8]
L_8c80ac:
	mov_s r1,0x2
	.global L_8c80ae
L_8c80ae:
	bl L_8ee034
	.global L_8c80b2
L_8c80b2:
	cmp_s r13,0xc
L_8c80b4:
	bhi L_8c7fa2
	.global L_8c80b8
L_8c80b8:
	b L_8c031c
