/* awake_peers__log @ 0x8dcdd8, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [DBG AWAKE PEERS] sw_vring=0x%02x | data_in_prev_bi=0x%02x | keep_alive=0x%02x |
 *   [NNL] atim_rx=0x%02x | bf_trigger=0x%02x | bcast=%d |
 *   [NNL] peer_eligibility=0x%02x | fw_mac_queue=0x%03x | local_in_doze=%d
 * Зовут его: lmac_if__awake_peers_evt
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit3
 */
	.section .text.awake_peers__log,"ax",@progbits
	.global awake_peers__log
awake_peers__log:
	.global L_8dcdd8
L_8dcdd8:
	push_s blink
L_8dcdda:
	bl.d L_8c02c0
L_8dcdde:
	mov_s r0,0xe
L_8dcde0:
	mov_s r13,0x857040
L_8dcde6:
	ldb r4,[r13, 0x15]
L_8dcdea:
	mov_s r2,0x10043b4
L_8dcdf0:
	ldb r5,[r13, 0x16]
L_8dcdf4:
	mov_s r14,0x857000
L_8dcdfa:
	mov_s r1,0x2
L_8dcdfc:
	bl.d L_8ee034
L_8dce00:
	ldb_s r3,[r13,0x14]
L_8dce02:
	mov_s r2,0x1004408
L_8dce08:
	ld_s r15,[r14,0x58]
L_8dce0a:
	ldb r4,[r13, 0x17]
L_8dce0e:
	mov_s r0,0xe
L_8dce10:
	ldb_s r3,[r13,0x18]
L_8dce12:
	mov_s r1,0x2
L_8dce14:
	lsr_s r15,r15,0x19
L_8dce16:
	bl.d L_8ee034
L_8dce1a:
	bmsk r5,r15,0x0
L_8dce1e:
	ld_s r14,[r14,0x58]
L_8dce20:
	mov_s r2,0x1004440
L_8dce26:
	lsr r0,r14,0x10
L_8dce2a:
	bmsk r4,r0,0x8
L_8dce2e:
	ldb_s r3,[r13,0x19]
L_8dce30:
	mov_s r0,0xe
L_8dce32:
	mov_s r1,0x2
L_8dce34:
	lsr_s r14,r14,0x1a
L_8dce36:
	bl.d L_8ee034
L_8dce3a:
	bmsk r5,r14,0x0
L_8dce3e:
	b L_8c032c
L_8dce42:
	nop_s
