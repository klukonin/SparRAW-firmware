/* lmac_if__ucode_event_dispatch @ 0x8dae80, 732 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Ucode->EVENT_UCODE_READY: type 0x0%x, curr tsf 0x%08x %08x
 *   Ucode->RX_ON_RSP        : type 0x0%x, curr tsf 0x%08x %08x
 *   Ucode->EVENT_ECHO       : type 0x0%x, curr tsf 0x%08x %08x
 *   Ucode->RX_OFF_RSP       : type 0x0%x, curr tsf 0x%08x %08x
 *   Ucode->NEW_LINK_EVT     : type 0x0%x, curr tsf 0x%08x %08x
 *   Ucode->BF_DONE_EVT      : type 0x0%x, curr tsf 0x%08x %08x
 *   Ucode->RS_DONE_EVT      : type 0x0%x, curr tsf 0x%08x %08x
 *   Ucode->EVENT_FLUSH_Q_DONE: type 0x0%x, curr tsf 0x%08x %08x
 * Зовёт сам: LMAC_IF__rs_started, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit3, fw_mailbox__has_space, fw_sysassert_fatal, lmac_if__abft_notify_evt, lmac_if__awake_peers_evt, lmac_if__bf_done_and_new_link, lmac_if__key_evt, lmac_if__lmac_ready_evt, lmac_if__mac_monitor_report
 */
	.section .text.lmac_if__ucode_event_dispatch,"ax",@progbits
	.global lmac_if__ucode_event_dispatch
lmac_if__ucode_event_dispatch:
	.byte 0x8f
	.byte 0xf2
	.global fwlog_Ucode_EVENT_UCODE_READY_type_0x0_x_curr_
fwlog_Ucode_EVENT_UCODE_READY_type_0x0_x_curr_:
L_8dae82:
	nop_s
L_8dae84:
	push_s blink
L_8dae86:
	bl L_8c02bc
L_8dae8a:
	sub_s sp,sp,0x8
L_8dae8c:
	mov_s r16,r0
L_8dae8e:
	mov_s r15,r1
L_8dae90:
	add r14,r1,0x10
L_8dae94:
	mov_s r1,sp
L_8dae96:
	mov_s r13,0x0
L_8dae98:
	mov_s r0,r13
L_8dae9a:
	bl.d L_8e4840
L_8dae9e:
	mov_s r2,r13
L_8daea0:
	ldw_s r1,[r15,0x4]
L_8daea2:
	cmp_s r1,0x28
L_8daea4:
	bhi L_8db138
L_8daea8:
	ldw.x.as r1,[0x801b98,r1]
L_8daeb0:
	add r0,pcl,0x8
L_8daeb4:
	add1_s r0,r0,r1
L_8daeb6:
	j_s [r0]
L_8daeb8:
	ld r4,[sp, 0x4]
L_8daebc:
	mov_s r2,0x1004754
L_8daec2:
	ld r5,[sp]
L_8daec6:
	mov_s r0,r13
L_8daec8:
	mov_s r1,0x2
L_8daeca:
	bl.d L_8ee034
L_8daece:
	mov_s r3,r13
L_8daed0:
	bl L_8ede5c
L_8daed4:
	b L_8db14c
L_8daed8:
	ld r4,[sp, 0x4]
L_8daedc:
	mov_s r2,0x1004790
L_8daee2:
	ld r5,[sp]
L_8daee6:
	mov_s r0,r13
L_8daee8:
	mov_s r1,0x2
L_8daeea:
	bl.d L_8ee034
L_8daeee:
	mov_s r3,0x1
L_8daef0:
	bl.d L_8caf90
L_8daef4:
	mov_s r0,r13
L_8daef6:
	b L_8db14c
L_8daefa:
	ld r4,[sp, 0x4]
L_8daefe:
	mov_s r2,0x10047cc
L_8daf04:
	ld r5,[sp]
L_8daf08:
	mov_s r0,r13
L_8daf0a:
	mov_s r1,0x2
L_8daf0c:
	bl.d L_8ee034
L_8daf10:
	mov_s r3,r1
L_8daf12:
	bl.d L_8d84f0
L_8daf16:
	mov_s r0,r14
L_8daf18:
	b L_8db14c
L_8daf1c:
	ld r4,[sp, 0x4]
L_8daf20:
	mov_s r2,0x1004808
L_8daf26:
	ld r5,[sp]
L_8daf2a:
	mov_s r0,r13
L_8daf2c:
	mov_s r1,0x2
L_8daf2e:
	bl.d L_8ee034
L_8daf32:
	mov_s r3,0x3
L_8daf34:
	bl.d L_8caf90
L_8daf38:
	mov_s r0,0x1
L_8daf3a:
	b L_8db14c
L_8daf3e:
	ld r4,[sp, 0x4]
L_8daf42:
	mov_s r2,0x1004844
L_8daf48:
	ld r5,[sp]
L_8daf4c:
	mov_s r0,r13
L_8daf4e:
	mov_s r1,0x2
L_8daf50:
	bl.d L_8ee034
L_8daf54:
	mov_s r3,0x5
L_8daf56:
	bl L_8c9fb4
L_8daf5a:
	mov_s r1,r0
L_8daf5c:
	bl.d L_8d8374
L_8daf60:
	mov_s r0,r14
L_8daf62:
	b L_8db14c
L_8daf66:
	ld r4,[sp, 0x4]
L_8daf6a:
	mov_s r2,0x1004880
L_8daf70:
	ld r5,[sp]
L_8daf74:
	mov_s r0,r13
L_8daf76:
	mov_s r1,0x2
L_8daf78:
	bl.d L_8ee034
L_8daf7c:
	mov_s r3,0x6
L_8daf7e:
	bl.d L_8d8188
L_8daf82:
	mov_s r0,r14
L_8daf84:
	b_s L_8db14c
L_8daf86:
	ld r4,[sp, 0x4]
L_8daf8a:
	mov_s r2,0x10048bc
L_8daf90:
	ld r5,[sp]
L_8daf94:
	mov_s r0,r13
L_8daf96:
	mov_s r1,0x2
L_8daf98:
	bl.d L_8ee034
L_8daf9c:
	mov_s r3,0x14
L_8daf9e:
	bl.d L_8d88e8
L_8dafa2:
	mov_s r0,r14
L_8dafa4:
	b_s L_8db14c
L_8dafa6:
	ld r4,[sp, 0x4]
L_8dafaa:
	mov_s r2,0x10048f8
L_8dafb0:
	ld r5,[sp]
L_8dafb4:
	mov_s r0,r13
L_8dafb6:
	mov_s r1,0x2
L_8dafb8:
	bl.d L_8ee034
L_8dafbc:
	mov_s r3,0x4
L_8dafbe:
	bl.d L_8d8524
L_8dafc2:
	mov_s r0,r14
L_8dafc4:
	b_s L_8db14c
L_8dafc6:
	ld r4,[sp, 0x4]
L_8dafca:
	mov_s r2,0x1004934
L_8dafd0:
	ld r5,[sp]
L_8dafd4:
	mov_s r0,r13
L_8dafd6:
	mov_s r1,0x2
L_8dafd8:
	bl.d L_8ee034
L_8dafdc:
	mov_s r3,0x8
L_8dafde:
	bl.d L_8d8e98
L_8dafe2:
	mov_s r0,r14
L_8dafe4:
	b_s L_8db14c
L_8dafe6:
	ld r4,[sp, 0x4]
L_8dafea:
	mov_s r2,0x1004970
L_8daff0:
	ld r5,[sp]
L_8daff4:
	mov_s r0,r13
L_8daff6:
	mov_s r1,0x2
L_8daff8:
	bl.d L_8ee034
L_8daffc:
	mov_s r3,0x9
L_8daffe:
	bl.d L_8d8620
L_8db002:
	mov_s r0,r14
L_8db004:
	b_s L_8db14c
L_8db006:
	ld r4,[sp, 0x4]
L_8db00a:
	mov_s r2,0x10049ac
L_8db010:
	ld r5,[sp]
L_8db014:
	mov_s r0,r13
L_8db016:
	mov_s r1,0x2
L_8db018:
	bl.d L_8ee034
L_8db01c:
	mov_s r3,0x11
L_8db01e:
	bl.d L_8d8bf4
L_8db022:
	mov_s r0,r14
L_8db024:
	b_s L_8db14c
L_8db026:
	ld r4,[sp, 0x4]
L_8db02a:
	mov_s r2,0x10049ec
L_8db030:
	ld r5,[sp]
L_8db034:
	mov_s r0,r13
L_8db036:
	mov_s r1,0x2
L_8db038:
	bl.d L_8ee034
L_8db03c:
	mov_s r3,0x13
L_8db03e:
	bl.d L_8d8984
L_8db042:
	mov_s r0,r14
L_8db044:
	b_s L_8db14c
L_8db046:
	ld r4,[sp, 0x4]
L_8db04a:
	mov_s r2,0x1004a28
L_8db050:
	ld r5,[sp]
L_8db054:
	mov_s r0,r13
L_8db056:
	mov_s r1,0x2
L_8db058:
	bl.d L_8ee034
L_8db05c:
	mov_s r3,0x15
L_8db05e:
	bl.d L_8d8bbc
L_8db062:
	mov_s r0,r14
L_8db064:
	b_s L_8db14c
L_8db066:
	ld r4,[sp, 0x4]
L_8db06a:
	mov_s r2,0x1004a6c
L_8db070:
	ld r5,[sp]
L_8db074:
	mov_s r0,r13
L_8db076:
	mov_s r1,0x2
L_8db078:
	bl.d L_8ee034
L_8db07c:
	mov_s r3,0x16
L_8db07e:
	bl L_8c9fb4
L_8db082:
	mov_s r1,r0
L_8db084:
	bl.d L_8d8078
L_8db088:
	mov_s r0,r14
L_8db08a:
	b_s L_8db14c
L_8db08c:
	ld r4,[sp, 0x4]
L_8db090:
	mov_s r2,0x1004aa8
L_8db096:
	ld r5,[sp]
L_8db09a:
	mov_s r0,r13
L_8db09c:
	mov_s r1,0x2
L_8db09e:
	bl.d L_8ee034
L_8db0a2:
	mov_s r3,0x17
L_8db0a4:
	bl.d L_8d865c
L_8db0a8:
	mov_s r0,r14
L_8db0aa:
	b_s L_8db14c
L_8db0ac:
	ld r4,[sp, 0x4]
L_8db0b0:
	mov_s r2,0x1004ae4
L_8db0b6:
	ld r5,[sp]
L_8db0ba:
	mov_s r0,r13
L_8db0bc:
	mov_s r1,0x2
L_8db0be:
	bl.d L_8ee034
L_8db0c2:
	mov_s r3,0x18
L_8db0c4:
	bl.d L_8d8ca0
L_8db0c8:
	mov_s r0,r14
L_8db0ca:
	b_s L_8db14c
L_8db0cc:
	ld r4,[sp, 0x4]
L_8db0d0:
	mov_s r2,0x1004b2c
L_8db0d6:
	ld r5,[sp]
L_8db0da:
	mov_s r0,r13
L_8db0dc:
	mov_s r1,0x2
L_8db0de:
	bl.d L_8ee034
L_8db0e2:
	mov_s r3,0x19
L_8db0e4:
	bl.d L_8d8cac
L_8db0e8:
	mov_s r0,r14
L_8db0ea:
	b_s L_8db14c
L_8db0ec:
	ld r4,[sp, 0x4]
L_8db0f0:
	mov_s r2,0x1004b68
L_8db0f6:
	ld r5,[sp]
L_8db0fa:
	mov_s r0,r13
L_8db0fc:
	mov_s r1,0x2
L_8db0fe:
	bl.d L_8ee034
L_8db102:
	mov_s r3,0x27
L_8db104:
	mov_s r0,0x804384
L_8db10a:
	bl.d L_8cb220
L_8db10e:
	mov_s r1,r14
L_8db110:
	b_s L_8db14c
L_8db112:
	ld r4,[sp, 0x4]
L_8db116:
	mov_s r2,0x1004bbc
L_8db11c:
	ld r5,[sp]
L_8db120:
	mov_s r0,r13
L_8db122:
	mov_s r1,0x2
L_8db124:
	bl.d L_8ee034
L_8db128:
	mov_s r3,0x28
L_8db12a:
	mov_s r0,0x80438c
L_8db130:
	bl.d L_8cb274
L_8db134:
	mov_s r1,r14
L_8db136:
	b_s L_8db14c
	.global L_8db138
L_8db138:
	mov_s r0,blink
L_8db13a:
	mov_s r2,0x1003e50
L_8db140:
	mov_s r1,0x47
L_8db142:
	bset_s r1,r1,0xc
L_8db144:
	bl.d L_8c82c0
L_8db148:
	mov r3,0x1ca
	.global L_8db14c
L_8db14c:
	add r0,r16,0x24
L_8db150:
	ld_s r1,[r0]
L_8db152:
	bl.d L_8d533c
L_8db156:
	st_s r13,[r1]
L_8db158:
	b.d L_8c0324
